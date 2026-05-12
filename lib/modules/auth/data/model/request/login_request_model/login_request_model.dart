
import 'package:taxi_app/modules/auth/domain/params/login_param.dart';

class LoginRequestModel extends LoginParam {
  const LoginRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}