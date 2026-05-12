import 'package:taxi_app/modules/auth/data/model/request/forgetpassword_request_model/forgetpassword_request_model.dart';

class ForgetpasswordParam {
  final String token;
  final String email;

  const ForgetpasswordParam({
    required this.token,
    required this.email,
  });

  ForgetpasswordRequestModel toModel() => ForgetpasswordRequestModel(
        token: token,
        email: email,
      );
}