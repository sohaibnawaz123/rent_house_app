import 'package:taxi_app/modules/dashboard/data/model/request/dashboardroot_request_model/dashboardroot_request_model.dart';

class DashboardrootParam {
  final String token;
  final String email;

  const DashboardrootParam({
    required this.token,
    required this.email,
  });

  DashboardrootRequestModel toModel() => DashboardrootRequestModel(
        token: token,
        email: email,
      );
}