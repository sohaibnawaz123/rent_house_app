import 'package:taxi_app/modules/dashboard/domain/entities/dashboardroot_entity.dart';

class DashboardrootModel {
  String? userMessage;
  bool? status;

  DashboardrootModel({
    this.userMessage,
    this.status,
  });

  factory DashboardrootModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      DashboardrootModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  DashboardrootEntity toEntity() {
    return DashboardrootEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
