part of 'forgetpassword_bloc.dart';

class ForgetpasswordState extends Equatable {
  final ForgetpasswordViewInitialParams initialParams;
  final ApiResponse<BaseEntity<ForgetpasswordEntity>> forgetpasswordResponse;

  const ForgetpasswordState({
    required this.initialParams,
    this.forgetpasswordResponse = const ApiResponse.init(),
  });

   ForgetpasswordState copyWith({
    ForgetpasswordViewInitialParams? initialParams,
    ApiResponse<BaseEntity<ForgetpasswordEntity>>? forgetpasswordResponse,
  }) {
    ForgetpasswordState data =   ForgetpasswordState(
      initialParams: initialParams ?? this.initialParams,
      forgetpasswordResponse: forgetpasswordResponse ?? this.forgetpasswordResponse,
    );
    Utils.logInfo(data.toString(), name: "Forgetpassword");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, forgetpasswordResponse];

  @override
  String toString() {
    return 'ForgetpasswordState(initialParams: $initialParams, forgetpasswordResponse: ${forgetpasswordResponse.toString()})';
  }
}
