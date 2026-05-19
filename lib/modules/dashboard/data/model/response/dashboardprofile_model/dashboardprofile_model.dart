import 'package:taxi_app/modules/dashboard/domain/entities/dashboardprofile_entity.dart';

class DashboardprofileModel {
  String? userMessage;
  bool? status;

  DashboardprofileModel({
    this.userMessage,
    this.status,
  });

  factory DashboardprofileModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      DashboardprofileModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  DashboardprofileEntity toEntity() {
    return DashboardprofileEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
