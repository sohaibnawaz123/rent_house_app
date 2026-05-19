
import 'package:taxi_app/modules/dashboard/domain/params/dashboardprofile_param.dart';

class DashboardprofileRequestModel extends DashboardprofileParam {
  const DashboardprofileRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}