import 'package:taxi_app/modules/auth/data/model/request/register_request_model/register_request_model.dart';

class RegisterParam {
  final String username;
  final String email;
  final String password;
  final String role;

  const RegisterParam({
    required this.email,
    required this.username,
    required this.password,
    required this.role,
  });

  RegisterRequestModel toModel() => RegisterRequestModel(
    email: email,
    username: username,
    password: password,
    role: role,
  );
}
