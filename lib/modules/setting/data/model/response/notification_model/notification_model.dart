import 'package:taxi_app/modules/setting/domain/entities/notification_entity.dart';

class NotificationModel {
  String? userMessage;
  bool? status;

  NotificationModel({
    this.userMessage,
    this.status,
  });

  factory NotificationModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      NotificationModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  NotificationEntity toEntity() {
    return NotificationEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
