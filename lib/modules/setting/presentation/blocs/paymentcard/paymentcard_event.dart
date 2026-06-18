part of 'paymentcard_bloc.dart';

sealed class PaymentcardEvent {}

class  LoadPaymentcardEvent extends PaymentcardEvent {
  final PaymentcardParam param;
   LoadPaymentcardEvent(this.param);
}
