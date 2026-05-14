part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final RegisterViewInitialParams initialParams;
  final ApiResponse<BaseEntity<RegisterEntity>> registerResponse;

  const RegisterState({
    required this.initialParams,
    this.registerResponse = const ApiResponse.init(),
  });

   RegisterState copyWith({
    RegisterViewInitialParams? initialParams,
    ApiResponse<BaseEntity<RegisterEntity>>? registerResponse,
  }) {
    RegisterState data =   RegisterState(
      initialParams: initialParams ?? this.initialParams,
      registerResponse: registerResponse ?? this.registerResponse,
    );
    Utils.logInfo(data.toString(), name: "Register");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, registerResponse];

  @override
  String toString() {
    return 'RegisterState(initialParams: $initialParams, registerResponse: ${registerResponse.toString()})';
  }
}
