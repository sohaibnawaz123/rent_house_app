
import 'package:taxi_app/modules/auth/domain/params/register_param.dart';

class RegisterRequestModel extends RegisterParam {
  const RegisterRequestModel({
    required super.username,
    required super.email,
    required super.password,
    required super.role,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
        'name': role,
      };
}