import 'package:taxi_app/modules/auth/data/model/request/login_request_model/login_request_model.dart';

class LoginParam {
  final String token;
  final String email;

  const LoginParam({
    required this.token,
    required this.email,
  });

  LoginRequestModel toModel() => LoginRequestModel(
        token: token,
        email: email,
      );
}