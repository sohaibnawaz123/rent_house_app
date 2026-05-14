import 'package:taxi_app/modules/auth/data/model/request/register_request_model/register_request_model.dart';

class RegisterParam {
  final String token;
  final String email;

  const RegisterParam({
    required this.token,
    required this.email,
  });

  RegisterRequestModel toModel() => RegisterRequestModel(
        token: token,
        email: email,
      );
}