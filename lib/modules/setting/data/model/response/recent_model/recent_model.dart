import 'package:taxi_app/modules/setting/domain/entities/recent_entity.dart';

class RecentModel {
  String? userMessage;
  bool? status;

  RecentModel({
    this.userMessage,
    this.status,
  });

  factory RecentModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      RecentModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  RecentEntity toEntity() {
    return RecentEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
