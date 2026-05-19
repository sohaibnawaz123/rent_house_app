import 'package:taxi_app/modules/dashboard/domain/entities/dashboardfavourite_entity.dart';

class DashboardfavouriteModel {
  String? userMessage;
  bool? status;

  DashboardfavouriteModel({
    this.userMessage,
    this.status,
  });

  factory DashboardfavouriteModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      DashboardfavouriteModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  DashboardfavouriteEntity toEntity() {
    return DashboardfavouriteEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
