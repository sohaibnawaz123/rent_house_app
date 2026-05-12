import 'package:taxi_app/modules/auth/data/model/request/resetpassword_request_model/resetpassword_request_model.dart';

class ResetpasswordParam {
  final String token;
  final String email;

  const ResetpasswordParam({
    required this.token,
    required this.email,
  });

  ResetpasswordRequestModel toModel() => ResetpasswordRequestModel(
        token: token,
        email: email,
      );
}