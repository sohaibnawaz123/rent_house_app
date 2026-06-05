import 'package:taxi_app/modules/setting/data/model/request/notification_request_model/notification_request_model.dart';

class NotificationParam {
  final String token;
  final String email;

  const NotificationParam({
    required this.token,
    required this.email,
  });

  NotificationRequestModel toModel() => NotificationRequestModel(
        token: token,
        email: email,
      );
}