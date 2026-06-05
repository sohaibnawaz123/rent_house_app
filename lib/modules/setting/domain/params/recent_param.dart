import 'package:taxi_app/modules/setting/data/model/request/recent_request_model/recent_request_model.dart';

class RecentParam {
  final String token;
  final String email;

  const RecentParam({
    required this.token,
    required this.email,
  });

  RecentRequestModel toModel() => RecentRequestModel(
        token: token,
        email: email,
      );
}