import 'dart:async';
import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/network_failure.dart';
import 'package:taxi_app/core/network/socket/socket_status.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

/// Centralized Socket Manager that handles connection lifecycle,
/// reconnection, and event streaming across the app
class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  factory SocketManager() => _instance;
  SocketManager._internal();

  io.Socket? _socket;
  final Map<String, StreamController<dynamic>> _eventControllers = {};
  final Map<String, StreamSubscription> _eventSubscriptions = {};
  final Set<String> _registeredEvents = {};

  // Add connection state stream controller
  final StreamController<SocketStatus> _connectionStateController =
      StreamController<SocketStatus>.broadcast();

  bool get isConnected => _socket?.connected ?? false;

  // Expose connection state stream
  Stream<SocketStatus> get connectionStateStream =>
      _connectionStateController.stream;

  /// Initialize socket connection
  Future<Either<NetworkFailure, bool>> connect({
    required String url,
    required Map<String, dynamic> options,
  }) async {
    try {
      if (_socket != null && _socket!.connected) {
        return right(true); // Already connected
      }

      final completer = Completer<Either<NetworkFailure, bool>>();
      _connectionStateController.add(SocketStatus.connecting);

      _socket = io.io(url, options);

      // Wait for actual connection
      _socket!.onConnect((_) {
        log('Socket connected');
        _connectionStateController.add(SocketStatus.connected);
        _reattachEventListeners();
        if (!completer.isCompleted) {
          completer.complete(right(true));
        }
      });

      _socket!.onDisconnect((_) {
        log('Socket disconnected');
        _connectionStateController.add(SocketStatus.disconnected);
      });

      _socket!.onReconnect((_) {
        log('Socket reconnected');
        _connectionStateController.add(SocketStatus.connected);
        _reattachEventListeners();
      });

      _socket!.onError((error) {
        log('Socket error: $error');
        _connectionStateController.add(SocketStatus.error);
      });

      _socket!.onConnectError((error) {
        log('Socket connection error: $error');
        _connectionStateController.add(SocketStatus.error);
        if (!completer.isCompleted) {
          completer.complete(
            left(NetworkFailure('Connection error: ${error.toString()}')),
          );
        }
      });

      // Set connection timeout
      Timer(const Duration(seconds: 10), () {
        if (!completer.isCompleted) {
          _connectionStateController.add(SocketStatus.error);
          completer.complete(
            left(NetworkFailure('Connection timeout after 10 seconds')),
          );
          _socket?.disconnect();
          _socket = null;
        }
      });

      return completer.future;
    } catch (e) {
      _connectionStateController.add(SocketStatus.error);
      return left(NetworkFailure('Failed to connect socket: ${e.toString()}'));
    }
  }

  /// Disconnect socket
  Either<NetworkFailure, bool> disconnect() {
    try {
      _socket?.disconnect();
      _socket?.dispose();
      _socket = null;
      _connectionStateController.add(SocketStatus.disconnected);
      return right(true);
    } catch (e) {
      return left(NetworkFailure('Failed to disconnect: ${e.toString()}'));
    }
  }

  /// Register an event listener and return a stream
  /// The stream survives reconnections automatically
  Stream<T> on<T>(String event, {T Function(dynamic)? parser}) {
    // Create stream controller if it doesn't exist
    if (!_eventControllers.containsKey(event)) {
      _eventControllers[event] = StreamController<T>.broadcast(
        onListen: () => _attachListener(event),
        onCancel: () => _detachListener(event),
      );
    }

    return _eventControllers[event]!.stream as Stream<T>;
  }

  /// Internal method to attach listener to socket
  void _attachListener(String event) {
    if (_socket == null || _registeredEvents.contains(event)) {
      return;
    }

    _registeredEvents.add(event);

    // Remove any existing listener first
    _socket!.off(event);

    // Attach new listener
    _socket!.on(event, (data) {
      if (_eventControllers.containsKey(event) &&
          !_eventControllers[event]!.isClosed) {
        _eventControllers[event]!.add(data);
      }
    });

    log('Attached listener for event: $event');
  }

  /// Internal method to detach listener from socket
  void _detachListener(String event) {
    if (!_eventControllers.containsKey(event)) {
      return;
    }

    // Check if stream still has listeners
    final controller = _eventControllers[event]!;
    if (!controller.hasListener) {
      _socket?.off(event);
      _registeredEvents.remove(event);
      controller.close();
      _eventControllers.remove(event);
      log('Detached listener for event: $event');
    }
  }

  /// Reattach all active event listeners after reconnection
  void _reattachEventListeners() {
    final eventsToReattach = List<String>.from(_registeredEvents);
    _registeredEvents.clear();

    for (final event in eventsToReattach) {
      if (_eventControllers.containsKey(event) &&
          _eventControllers[event]!.hasListener) {
        _attachListener(event);
      }
    }

    log('Reattached ${eventsToReattach.length} event listeners');
  }

  /// Emit an event without acknowledgment
  Either<NetworkFailure, bool> emit(String event, dynamic data) {
    try {
      if (_socket == null || !_socket!.connected) {
        return left(NetworkFailure('Cannot emit event: Socket not connected'));
      }

      _socket!.emit(event, data);
      return right(true);
    } catch (e) {
      return left(NetworkFailure('Failed to emit event: ${e.toString()}'));
    }
  }

  /// Emit an event with acknowledgment
  Future<Either<NetworkFailure, T>> emitWithAck<T>(
    String event,
    dynamic data, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    try {
      if (_socket == null || !_socket!.connected) {
        return left(NetworkFailure('Cannot emit event: Socket not connected'));
      }

      final completer = Completer<Either<NetworkFailure, T>>();

      _socket!.emitWithAck(
        event,
        data,
        ack: (response) {
          if (!completer.isCompleted) {
            try {
              completer.complete(right(response as T));
            } catch (e) {
              completer.complete(
                left(NetworkFailure('Invalid response type: ${e.toString()}')),
              );
            }
          }
        },
      );

      // Handle timeout
      Timer(timeout, () {
        if (!completer.isCompleted) {
          completer.complete(
            left(NetworkFailure('Request timeout after ${timeout.inSeconds}s')),
          );
        }
      });

      return completer.future;
    } catch (e) {
      return left(NetworkFailure('Failed to emit with ack: ${e.toString()}'));
    }
  }

  /// Clean up all resources
  void dispose() {
    for (final controller in _eventControllers.values) {
      controller.close();
    }
    _eventControllers.clear();
    _eventSubscriptions.clear();
    _registeredEvents.clear();
    _connectionStateController.close();
    disconnect();
  }
}
