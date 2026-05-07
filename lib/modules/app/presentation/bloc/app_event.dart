// part of 'app_bloc.dart';

// @immutable
// sealed class AppEvent {}

// class ReadLocalUserEvent extends AppEvent {}

// class WriteLocalUserEvent extends AppEvent {
//   final AuthUserDataEntity data;
//   WriteLocalUserEvent(this.data);
// }

// class UpdateLocalUserTokenEvent extends AppEvent {
//   final TokenRefreshDataEntity data;
//   UpdateLocalUserTokenEvent(this.data);
// }

// class WriteCredentialsEvent extends AppEvent {
//   final CredentialsEntity data;
//   WriteCredentialsEvent(this.data);
// }

// class ReadCredentialsEvent extends AppEvent {
//   ReadCredentialsEvent();
// }

// class DeleteUserEvent extends AppEvent {
//   final String key = UserStoreKey.user;
//   DeleteUserEvent();
// }

// class DeleteLovEvent extends AppEvent {
//   final String key = UserStoreKey.lov;
//   DeleteLovEvent();
// }

// class DeleteCredentialsEvent extends AppEvent {
//   final String key = UserStoreKey.credentials;
//   DeleteCredentialsEvent();
// }

// class GetLovEvent extends AppEvent {
//   final LovGetEntity data;
//   GetLovEvent(this.data);
// }

// class ReadLocalLovEvent extends AppEvent {}

// class GetFcmEvent extends AppEvent {}

// class ConnectSocketEvent extends AppEvent {
//   final SocketConnectionEntity data;
//   ConnectSocketEvent(this.data);
// }

// class SocketConnectivityEvent extends AppEvent {
//   final SocketStatus data;
//   SocketConnectivityEvent(this.data);
// }

// class NewMessageEvent extends AppEvent {
//   final Either<LovFailure, dynamic> data;
//   NewMessageEvent(this.data);
// }

// class SocketDisconnectEvent extends AppEvent {
//   SocketDisconnectEvent();
// }
