
import 'package:taxi_app/modules/setting/domain/params/notification_param.dart';

class NotificationRequestModel extends NotificationParam {
  const NotificationRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}