
import 'package:taxi_app/modules/dashboard/domain/params/dashboardexplore_param.dart';

class DashboardexploreRequestModel extends DashboardexploreParam {
  const DashboardexploreRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}