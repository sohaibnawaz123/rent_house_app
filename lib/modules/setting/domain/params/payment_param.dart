import 'package:taxi_app/modules/setting/data/model/request/payment_request_model/payment_request_model.dart';

class PaymentParam {
  final String token;
  final String email;

  const PaymentParam({
    required this.token,
    required this.email,
  });

  PaymentRequestModel toModel() => PaymentRequestModel(
        token: token,
        email: email,
      );
}