
import 'package:taxi_app/modules/auth/domain/params/otpverification_param.dart';

class OtpverificationRequestModel extends OtpverificationParam {
  const OtpverificationRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}