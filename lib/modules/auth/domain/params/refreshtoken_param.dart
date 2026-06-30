import 'package:taxi_app/modules/auth/data/model/request/refreshtoken_request_model/refreshtoken_request_model.dart';

class RefreshtokenParam {
  final String token;
  final String email;

  const RefreshtokenParam({
    required this.token,
    required this.email,
  });

  RefreshtokenRequestModel toModel() => RefreshtokenRequestModel(
        token: token,
        email: email,
      );
}