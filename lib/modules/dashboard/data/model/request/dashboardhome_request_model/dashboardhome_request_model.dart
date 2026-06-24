
import 'package:taxi_app/modules/dashboard/domain/params/dashboardhome_param.dart';

class DashboardhomeRequestModel extends DashboardhomeParam {
  const DashboardhomeRequestModel({
    required super.token,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}