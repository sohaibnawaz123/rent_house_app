part of 'otpverification_bloc.dart';

class OtpverificationState extends Equatable {
  final OtpverificationViewInitialParams initialParams;
  final ApiResponse<BaseEntity<OtpverificationEntity>> otpverificationResponse;

  const OtpverificationState({
    required this.initialParams,
    this.otpverificationResponse = const ApiResponse.init(),
  });

   OtpverificationState copyWith({
    OtpverificationViewInitialParams? initialParams,
    ApiResponse<BaseEntity<OtpverificationEntity>>? otpverificationResponse,
  }) {
    OtpverificationState data =   OtpverificationState(
      initialParams: initialParams ?? this.initialParams,
      otpverificationResponse: otpverificationResponse ?? this.otpverificationResponse,
    );
    Utils.logInfo(data.toString(), name: "Otpverification");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, otpverificationResponse];

  @override
  String toString() {
    return 'OtpverificationState(initialParams: $initialParams, otpverificationResponse: ${otpverificationResponse.toString()})';
  }
}
