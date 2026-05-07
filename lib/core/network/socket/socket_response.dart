import 'socket_status.dart';

class SocketResponse<T> {
  SocketStatus? status;
  String? message;
  T? socket;

  SocketResponse(this.status, this.message);

  SocketResponse.init() : status = SocketStatus.init;
  SocketResponse.connecting() : status = SocketStatus.connecting;
  SocketResponse.connected(this.socket) : status = SocketStatus.connected;
  SocketResponse.error(this.message) : status = SocketStatus.error;

  @override
  String toString() {
    return " Status : $status \n Message :  $message \n Socket: ${socket.toString()}";
  }
}
