part of 'payment_bloc.dart';

sealed class PaymentEvent {}

class  LoadPaymentEvent extends PaymentEvent {
  final PaymentParam param;
   LoadPaymentEvent(this.param);
}
