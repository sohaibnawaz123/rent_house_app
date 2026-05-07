// part of 'app_bloc.dart';

// @immutable
// class AppState {
//   final AuthUserDataEntity user;
//   final CredentialsEntity credentials;
//   final LovEntity lovData;
//   final ApiResponse<BaseEntity<LovEntity>> lovResponse;
//   final String fcm;
//   // final SocketResponse<io.Socket>? socket;
//   final SocketStatus? socketStatus;

//   const AppState({
//     required this.user,
//     required this.credentials,
//     required this.lovData,
//     this.lovResponse = const ApiResponse.init(),
//     this.fcm = 'abc',
//     // this.socket,
//     this.socketStatus,
//   });

//   AppState copyWith({
//     AuthUserDataEntity? user,
//     CredentialsEntity? credentials,
//     LovEntity? lovData,
//     ApiResponse<BaseEntity<LovEntity>>? lovResponse,
//     String? fcm,
//     SocketResponse<io.Socket>? socket,
//     SocketStatus? socketStatus,
//   }) {
//     AppState data = AppState(
//       user: user ?? this.user,
//       credentials: credentials ?? this.credentials,
//       lovData: lovData ?? this.lovData,
//       lovResponse: lovResponse ?? this.lovResponse,
//       fcm: fcm ?? this.fcm,
//       // socket: socket ?? this.socket,
//       socketStatus: socketStatus ?? this.socketStatus,
//     );
//     Utils.logInfo(data.toString(), name: "App State");
//     return data;
//   }

//   @override
//   String toString() {
//     return 'AppState(${user.toString()}, credential: ${credentials.toString()}, lovResponse: ${lovResponse.toString()}, lovData: ${lovData.toString()}, fcm: ${fcm.toString()}, socketStatus: ${socketStatus.toString()})';
//   }
// }
