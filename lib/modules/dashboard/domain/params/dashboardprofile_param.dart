import 'package:taxi_app/modules/dashboard/data/model/request/dashboardprofile_request_model/dashboardprofile_request_model.dart';

class DashboardprofileParam {
  final String token;
  final String email;

  const DashboardprofileParam({
    required this.token,
    required this.email,
  });

  DashboardprofileRequestModel toModel() => DashboardprofileRequestModel(
        token: token,
        email: email,
      );
}