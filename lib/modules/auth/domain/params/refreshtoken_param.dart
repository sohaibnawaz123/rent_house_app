import 'package:taxi_app/modules/auth/data/model/request/refreshtoken_request_model/refreshtoken_request_model.dart';

class RefreshtokenParam {
  final String token;

  const RefreshtokenParam({
    required this.token,
  });

  RefreshtokenRequestModel toModel() => RefreshtokenRequestModel(
        token: token,
      );
}
