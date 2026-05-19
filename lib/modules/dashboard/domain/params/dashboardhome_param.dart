import 'package:taxi_app/modules/dashboard/data/model/request/dashboardhome_request_model/dashboardhome_request_model.dart';

class DashboardhomeParam {
  final String token;
  final String email;

  const DashboardhomeParam({
    required this.token,
    required this.email,
  });

  DashboardhomeRequestModel toModel() => DashboardhomeRequestModel(
        token: token,
        email: email,
      );
}