part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final SignupViewInitialParams initialParams;
  final ApiResponse<BaseEntity<SignupEntity>> signupResponse;

  const SignupState({
    required this.initialParams,
    this.signupResponse = const ApiResponse.init(),
  });

   SignupState copyWith({
    SignupViewInitialParams? initialParams,
    ApiResponse<BaseEntity<SignupEntity>>? signupResponse,
  }) {
    SignupState data =   SignupState(
      initialParams: initialParams ?? this.initialParams,
      signupResponse: signupResponse ?? this.signupResponse,
    );
    Utils.logInfo(data.toString(), name: "Signup");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, signupResponse];

  @override
  String toString() {
    return 'SignupState(initialParams: $initialParams, signupResponse: ${signupResponse.toString()})';
  }
}
