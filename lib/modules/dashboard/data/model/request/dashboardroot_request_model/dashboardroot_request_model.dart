
import 'package:taxi_app/modules/dashboard/domain/params/dashboardroot_param.dart';

class DashboardrootRequestModel extends DashboardrootParam {
  const DashboardrootRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}