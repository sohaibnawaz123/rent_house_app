// import 'dart:async';

// import 'package:fpdart/fpdart.dart';
// import 'package:meta/meta.dart';

// import 'package:taxi_app/core/utils/utils.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;

// part 'app_event.dart';
// part 'app_state.dart';

// class AppBloc extends Bloc<AppEvent, AppState> {
//   final AppUseCase _useCase;
//   AppBloc(this._useCase)
//     : super(
//         AppState(
//           user: AuthUserDataEntity.empty(),
//           credentials: CredentialsEntity.empty(),
//           lovData: LovEntity.empty(),
//         ),
//       ) {
//     on<ReadLocalUserEvent>(_readAction);
//     on<WriteLocalUserEvent>(_writeAction);
//     on<UpdateLocalUserTokenEvent>(_updateTokenAction);

//     on<DeleteUserEvent>(_deleteUser);
//     on<WriteCredentialsEvent>(_writeRememberMe);
//     on<ReadCredentialsEvent>(_readRememberMe);
//     on<DeleteCredentialsEvent>(_deleteCredentials);
//     on<GetLovEvent>(_getLov);
//     on<ReadLocalLovEvent>(_readLov);
//     on<DeleteLovEvent>(_deleteLov);
//     on<GetFcmEvent>(_getFcmAction);
//     on<ConnectSocketEvent>(_connectSocketAction);
//     on<SocketDisconnectEvent>(_disconnectSocketAction);

//     on<SocketConnectivityEvent>(_onConnectionStateChanged);
//     // on<NewMessageEvent>(_onNewMessage);
//   }

//   // Keep the subscription so we can cancel it on close
//   StreamSubscription<SocketStatus>? _connectionSub;
//   StreamSubscription<Either<LovFailure, dynamic>>? _messageSub;

//   Future<void> _readAction(
//     ReadLocalUserEvent event,
//     Emitter<AppState> emit,
//   ) async {
//     Utils.logInfo("ReadLocalUserEvent", name: "Read");
//     await _useCase.userStore.executeReadUser().then(
//       (value) => value.fold(
//         (l) {
//           Utils.logInfo(l.error, name: "App");
//         },
//         (user) {
//           Utils.logInfo(user.toString(), name: "App");
//           emit(state.copyWith(user: user));
//         },
//       ),
//     );
//   }

//   Future<void> _writeAction(
//     WriteLocalUserEvent event,
//     Emitter<AppState> emit,
//   ) async {
//     await _useCase.userStore
//         .executeWriteUser(event.data)
//         .then(
//           (value) => value.fold(
//             (l) {
//               Utils.logInfo(l.error, name: "App");
//             },
//             (user) {
//               Utils.logInfo(user.toString(), name: "App");
//               emit(state.copyWith(user: user));
//             },
//           ),
//         );
//   }

//   Future<void> _updateTokenAction(
//     UpdateLocalUserTokenEvent event,
//     Emitter<AppState> emit,
//   ) async {
//     await _useCase.userStore
//         .executeWriteUser(
//           state.user.copyWith(
//             accessToken: event.data.accessToken,
//             refreshToken: event.data.refreshToken,
//           ),
//         )
//         .then(
//           (value) => value.fold(
//             (l) {
//               Utils.logInfo(l.error, name: "App");
//             },
//             (user) {
//               Utils.logInfo(user.toString(), name: "App");
//               emit(state.copyWith(user: user));
//             },
//           ),
//         );
//   }

//   Future<void> _deleteUser(
//     DeleteUserEvent event,
//     Emitter<AppState> emit,
//   ) async {
//     await _useCase.userStore
//         .executeDelete(event.key)
//         .then(
//           (value) => value.fold(
//             (l) {
//               Utils.logError(l.error, name: "App");
//             },
//             (user) {
//               Utils.logInfo(user.toString(), name: "App");
//               emit(state.copyWith(user: AuthUserDataEntity.empty()));
//             },
//           ),
//         );
//   }

//   Future<void> _deleteLov(DeleteLovEvent event, Emitter<AppState> emit) async {
//     await _useCase.userStore
//         .executeDelete(event.key)
//         .then(
//           (value) => value.fold(
//             (l) {
//               Utils.logInfo(l.error, name: "App");
//             },
//             (user) {
//               Utils.logInfo(user.toString(), name: "App");
//               emit(state.copyWith(lovData: LovEntity.empty()));
//             },
//           ),
//         );
//   }

//   Future<void> _writeRememberMe(
//     WriteCredentialsEvent event,
//     Emitter<AppState> emit,
//   ) async {
//     await _useCase.userStore
//         .executeWriteCredential(event.data)
//         .then(
//           (value) => value.fold(
//             (l) {
//               Utils.logInfo(l.error, name: "App");
//             },
//             (user) {
//               Utils.logInfo(user.toString(), name: "App");
//               emit(state.copyWith(credentials: event.data));
//             },
//           ),
//         );
//   }

//   Future<void> _readRememberMe(
//     ReadCredentialsEvent event,
//     Emitter<AppState> emit,
//   ) async {
//     await _useCase.userStore.executeReadCredential().then(
//       (value) => value.fold(
//         (l) {
//           Utils.logInfo(l.error, name: "App");
//         },
//         (creds) {
//           Utils.logInfo(creds.toString(), name: "App creds");
//           emit(state.copyWith(credentials: creds));
//         },
//       ),
//     );
//   }

//   Future<void> _deleteCredentials(
//     DeleteCredentialsEvent event,
//     Emitter<AppState> emit,
//   ) async {
//     await _useCase.userStore
//         .executeDelete(event.key)
//         .then(
//           (value) => value.fold(
//             (l) {
//               Utils.logInfo(l.error, name: "App");
//             },
//             (user) {
//               Utils.logInfo(user.toString(), name: "App");
//               emit(state.copyWith(credentials: CredentialsEntity.empty()));
//             },
//           ),
//         );
//   }

//   Future<void> _getLov(GetLovEvent event, Emitter<AppState> emit) async {
//     emit(state.copyWith(lovResponse: ApiResponse.loading()));
//     await _useCase.lovUseCase
//         .execute(event.data)
//         .then(
//           (value) => value.fold(
//             (l) {
//               emit(state.copyWith(lovResponse: ApiResponse.error(l.error)));
//             },
//             (r) {
//               emit(
//                 state.copyWith(
//                   lovResponse: ApiResponse.completed(r),
//                   lovData: r.data,
//                 ),
//               );
//               _useCase.userStore.executeWriteLov(r.data);
//             },
//           ),
//         );
//   }

//   Future<void> _readLov(ReadLocalLovEvent event, Emitter<AppState> emit) async {
//     Utils.logInfo("ReadLocalLovEvent", name: "Read Lov");
//     await _useCase.userStore.executeReadLov().then(
//       (value) => value.fold(
//         (l) {
//           Utils.logError(l.error, name: "App Lov");
//         },
//         (lov) {
//           Utils.logInfo(lov.toString(), name: "App Lov");
//           emit(state.copyWith(lovData: lov));
//         },
//       ),
//     );
//   }

//   Future<void> _getFcmAction(GetFcmEvent event, Emitter<AppState> emit) async {
//     Utils.logInfo("Get FCM", name: "FCM");
//     await _useCase.notificationServiceUseCase.getFCM().then(
//       (value) => value.fold(
//         (l) {
//           Utils.logError(l.error, name: "FCM");
//         },
//         (fcm) {
//           Utils.logInfo(fcm.toString(), name: "FCM");
//           emit(state.copyWith(fcm: fcm));
//         },
//       ),
//     );
//   }

//   Future<void> _connectSocketAction(
//     ConnectSocketEvent event,
//     Emitter<AppState> emit,
//   ) async {
//     emit(state.copyWith(socketStatus: SocketStatus.connecting));

//     Utils.logInfo("Connect Socket", name: "Socket");

//     await _useCase.socketUseCase
//         .executeConnectSocket(event.data)
//         .then(
//           (val) => val.fold(
//             (l) => emit(state.copyWith(socketStatus: SocketStatus.error)),
//             (r) {
//               // Start listening to connection state changes
//               _startConnectionStateListening();
//               emit(state.copyWith(socketStatus: SocketStatus.connected));
//             },
//           ),
//         );
//     // await _useCase.socketIoStreamUseCase
//     //     .executeConnectSocket(event.data)
//     //     .then(
//     //       (value) => value.fold(
//     //         (l) {
//     //           Utils.logError(l.error, name: "Socket");
//     //           emit(
//     //             state.copyWith(
//     //               socket: SocketResponse.error(l.error),
//     //               socketStatus: SocketStatus.error,
//     //             ),
//     //           );
//     //         },
//     //         (socket) {
//     //           Utils.logInfo("Socket Connected", name: "Socket");
//     //           emit(
//     //             state.copyWith(
//     //               socket: SocketResponse.connected(socket),
//     //               socketStatus: SocketStatus.connected,
//     //             ),
//     //           );
//     //           Timer(const Duration(milliseconds: 1500), () {
//     //             _startConnectionStateListening();
//     //             _startMessageListening(socket);
//     //           });
//     //         },
//     //       ),
//     //     );
//   }

//   Future<void> _disconnectSocketAction(
//     SocketDisconnectEvent event,
//     Emitter<AppState> emit,
//   ) async {
//     await _useCase.socketUseCase.executeDisconnectSocket().then(
//       (value) => value.fold(
//         (l) {
//           Utils.logError(l.error, name: "Socket Disconnect");
//         },
//         (r) {
//           Utils.logInfo(r.toString(), name: "Socket Disconnect");
//           emit(state.copyWith(socketStatus: SocketStatus.disconnected));
//         },
//       ),
//     );
//   }

//   // -----------------------------------------------------------------
//   //  Stream → internal event
//   // -----------------------------------------------------------------
//   void _startConnectionStateListening() {
//     _connectionSub?.cancel(); // Cancel previous subscription
//     _connectionSub = _useCase.socketUseCase.connectionStateStream.listen(
//       (newState) => add(SocketConnectivityEvent(newState)),
//     );
//   }

//   // void _startMessageListening(io.Socket socket) {
//   //   _messageSub?.cancel(); // Cancel previous if any
//   //   _messageSub = _useCase.socketIoStreamUseCase
//   //       .executeListenNewMessage(socket)
//   //       .listen((event) => add(NewMessageEvent(event)));
//   // }

//   // Future<void> _onNewMessage(
//   //   NewMessageEvent event,
//   //   Emitter<AppState> emit,
//   // ) async {
//   //   event.data.fold(
//   //     (failure) => Utils.logError(failure.error, name: "New Message Socket"),
//   //     (message) =>
//   //         Utils.logError(message.toString(), name: "New Message Socket"),
//   //   );
//   // }

//   Future<void> _onConnectionStateChanged(
//     SocketConnectivityEvent event,
//     Emitter<AppState> emit,
//   ) async {
//     Utils.logInfo("Socket status changed: ${event.data}", name: "Socket");
//     emit(state.copyWith(socketStatus: event.data));
//   }

//   // -----------------------------------------------------------------
//   //  Clean-up
//   // -----------------------------------------------------------------
//   @override
//   Future<void> close() async {
//     await _connectionSub?.cancel();
//     await _messageSub?.cancel();
//     return super.close();
//   }
// }
