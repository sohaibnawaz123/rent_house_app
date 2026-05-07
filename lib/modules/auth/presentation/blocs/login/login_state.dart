part of 'login_bloc.dart';

class LoginState extends Equatable {
  final LoginViewInitialParams initialParams;
  final ApiResponse<BaseEntity<LoginEntity>> loginResponse;

  const LoginState({
    required this.initialParams,
    this.loginResponse = const ApiResponse.init(),
  });

   LoginState copyWith({
    LoginViewInitialParams? initialParams,
    ApiResponse<BaseEntity<LoginEntity>>? loginResponse,
  }) {
    LoginState data =   LoginState(
      initialParams: initialParams ?? this.initialParams,
      loginResponse: loginResponse ?? this.loginResponse,
    );
    Utils.logInfo(data.toString(), name: "Login");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, loginResponse];

  @override
  String toString() {
    return 'LoginState(initialParams: $initialParams, loginResponse: ${loginResponse.toString()})';
  }
}
