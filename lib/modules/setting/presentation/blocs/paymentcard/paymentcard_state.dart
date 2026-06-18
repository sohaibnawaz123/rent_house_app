part of 'paymentcard_bloc.dart';

class PaymentcardState extends Equatable {
  final PaymentcardViewInitialParams initialParams;
  final ApiResponse<BaseEntity<PaymentcardEntity>> paymentcardResponse;

  const PaymentcardState({
    required this.initialParams,
    this.paymentcardResponse = const ApiResponse.init(),
  });

   PaymentcardState copyWith({
    PaymentcardViewInitialParams? initialParams,
    ApiResponse<BaseEntity<PaymentcardEntity>>? paymentcardResponse,
  }) {
    PaymentcardState data =   PaymentcardState(
      initialParams: initialParams ?? this.initialParams,
      paymentcardResponse: paymentcardResponse ?? this.paymentcardResponse,
    );
    Utils.logInfo(data.toString(), name: "Paymentcard");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, paymentcardResponse];

  @override
  String toString() {
    return 'PaymentcardState(initialParams: $initialParams, paymentcardResponse: ${paymentcardResponse.toString()})';
  }
}
