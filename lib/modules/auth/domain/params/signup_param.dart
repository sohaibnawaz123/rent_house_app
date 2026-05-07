import 'package:taxi_app/modules/auth/data/model/request/signup_request_model/signup_request_model.dart';

class SignupParam {
  final String token;
  final String email;

  const SignupParam({
    required this.token,
    required this.email,
  });

  SignupRequestModel toModel() => SignupRequestModel(
        token: token,
        email: email,
      );
}