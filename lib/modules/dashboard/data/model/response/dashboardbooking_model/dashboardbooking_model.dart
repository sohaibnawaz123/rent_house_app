import 'package:taxi_app/modules/dashboard/domain/entities/dashboardbooking_entity.dart';

class DashboardbookingModel {
  String? userMessage;
  bool? status;

  DashboardbookingModel({
    this.userMessage,
    this.status,
  });

  factory DashboardbookingModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      DashboardbookingModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  DashboardbookingEntity toEntity() {
    return DashboardbookingEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
