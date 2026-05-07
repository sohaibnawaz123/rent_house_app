
import 'package:taxi_app/modules/auth/domain/params/signup_param.dart';

class SignupRequestModel extends SignupParam {
  const SignupRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}