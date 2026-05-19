import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entity.dart';

class DashboardhomeModel {
  String? userMessage;
  bool? status;

  DashboardhomeModel({
    this.userMessage,
    this.status,
  });

  factory DashboardhomeModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      DashboardhomeModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  DashboardhomeEntity toEntity() {
    return DashboardhomeEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
