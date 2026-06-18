
import 'package:taxi_app/modules/setting/domain/params/paymentcard_param.dart';

class PaymentcardRequestModel extends PaymentcardParam {
  const PaymentcardRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}