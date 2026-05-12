import 'package:taxi_app/modules/auth/data/model/request/otpverification_request_model/otpverification_request_model.dart';

class OtpverificationParam {
  final String token;
  final String email;

  const OtpverificationParam({
    required this.token,
    required this.email,
  });

  OtpverificationRequestModel toModel() => OtpverificationRequestModel(
        token: token,
        email: email,
      );
}