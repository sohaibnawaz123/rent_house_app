import 'package:taxi_app/modules/auth/data/model/request/login_request_model/login_request_model.dart';

class LoginParam {
  final String email;
  final String password;

  const LoginParam({
    required this.password,
    required this.email,
  });

  LoginRequestModel toModel() => LoginRequestModel(
        password: password,
        email: email,
      );
}