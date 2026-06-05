
import 'package:taxi_app/modules/setting/domain/params/payment_param.dart';

class PaymentRequestModel extends PaymentParam {
  const PaymentRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}