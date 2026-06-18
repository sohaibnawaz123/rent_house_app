import 'package:taxi_app/modules/setting/data/model/request/paymentcard_request_model/paymentcard_request_model.dart';

class PaymentcardParam {
  final String token;
  final String email;

  const PaymentcardParam({
    required this.token,
    required this.email,
  });

  PaymentcardRequestModel toModel() => PaymentcardRequestModel(
        token: token,
        email: email,
      );
}