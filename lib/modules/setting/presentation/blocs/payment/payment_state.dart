part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  final PaymentViewInitialParams initialParams;
  final ApiResponse<BaseEntity<PaymentEntity>> paymentResponse;

  const PaymentState({
    required this.initialParams,
    this.paymentResponse = const ApiResponse.init(),
  });

   PaymentState copyWith({
    PaymentViewInitialParams? initialParams,
    ApiResponse<BaseEntity<PaymentEntity>>? paymentResponse,
  }) {
    PaymentState data =   PaymentState(
      initialParams: initialParams ?? this.initialParams,
      paymentResponse: paymentResponse ?? this.paymentResponse,
    );
    Utils.logInfo(data.toString(), name: "Payment");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, paymentResponse];

  @override
  String toString() {
    return 'PaymentState(initialParams: $initialParams, paymentResponse: ${paymentResponse.toString()})';
  }
}
