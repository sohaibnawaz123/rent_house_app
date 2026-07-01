part of 'login_bloc.dart';

class LoginState extends Equatable {
  final LoginViewInitialParams initialParams;
  final ApiResponse<BaseEntity<LoginEntity>> loginResponse;
  final ApiResponse<BaseEntity<LogoutEntity>> logoutResponse;

  const LoginState({
    required this.initialParams,
    this.loginResponse = const ApiResponse.init(),
    this.logoutResponse = const ApiResponse.init(),
  });

   LoginState copyWith({
    LoginViewInitialParams? initialParams,
    ApiResponse<BaseEntity<LoginEntity>>? loginResponse,
    ApiResponse<BaseEntity<LogoutEntity>>? logoutResponse,
  }) {
    LoginState data =   LoginState(
      initialParams: initialParams ?? this.initialParams,
      loginResponse: loginResponse ?? this.loginResponse,
      logoutResponse: logoutResponse ?? this.logoutResponse,
    );
    Utils.logInfo(data.toString(), name: "Login");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, loginResponse, logoutResponse];

  @override
  String toString() {
    return 'LoginState(initialParams: $initialParams, loginResponse: ${loginResponse.toString()}, logoutResponse: ${logoutResponse.toString()})';
  }
}
