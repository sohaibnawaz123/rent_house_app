import 'package:taxi_app/modules/dashboard/data/model/request/dashboardhome_request_model/dashboardhome_request_model.dart';

class DashboardhomeParam {
  final String token;

  const DashboardhomeParam({
    required this.token,
  });

  DashboardhomeRequestModel toModel() => DashboardhomeRequestModel(
        token: token,
      );
}