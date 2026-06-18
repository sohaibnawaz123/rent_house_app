import 'package:taxi_app/modules/activity/data/model/request/reserve_request_model/reserve_request_model.dart';

class ReserveParam {
  final String token;
  final String email;

  const ReserveParam({
    required this.token,
    required this.email,
  });

  ReserveRequestModel toModel() => ReserveRequestModel(
        token: token,
        email: email,
      );
}