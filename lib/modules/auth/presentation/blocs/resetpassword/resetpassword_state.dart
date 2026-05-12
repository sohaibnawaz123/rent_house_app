part of 'resetpassword_bloc.dart';

class ResetpasswordState extends Equatable {
  final ResetpasswordViewInitialParams initialParams;
  final ApiResponse<BaseEntity<ResetpasswordEntity>> resetpasswordResponse;

  const ResetpasswordState({
    required this.initialParams,
    this.resetpasswordResponse = const ApiResponse.init(),
  });

   ResetpasswordState copyWith({
    ResetpasswordViewInitialParams? initialParams,
    ApiResponse<BaseEntity<ResetpasswordEntity>>? resetpasswordResponse,
  }) {
    ResetpasswordState data =   ResetpasswordState(
      initialParams: initialParams ?? this.initialParams,
      resetpasswordResponse: resetpasswordResponse ?? this.resetpasswordResponse,
    );
    Utils.logInfo(data.toString(), name: "Resetpassword");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, resetpasswordResponse];

  @override
  String toString() {
    return 'ResetpasswordState(initialParams: $initialParams, resetpasswordResponse: ${resetpasswordResponse.toString()})';
  }
}
