import 'package:taxi_app/modules/dashboard/domain/entities/dashboardexplore_entity.dart';

class DashboardexploreModel {
  String? userMessage;
  bool? status;

  DashboardexploreModel({
    this.userMessage,
    this.status,
  });

  factory DashboardexploreModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      DashboardexploreModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  DashboardexploreEntity toEntity() {
    return DashboardexploreEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
