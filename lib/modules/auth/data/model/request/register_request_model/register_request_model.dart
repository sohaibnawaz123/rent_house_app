
import 'package:taxi_app/modules/auth/domain/params/register_param.dart';

class RegisterRequestModel extends RegisterParam {
  const RegisterRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}