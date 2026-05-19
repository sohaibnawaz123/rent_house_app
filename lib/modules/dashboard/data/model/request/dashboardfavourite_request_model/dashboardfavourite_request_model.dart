
import 'package:taxi_app/modules/dashboard/domain/params/dashboardfavourite_param.dart';

class DashboardfavouriteRequestModel extends DashboardfavouriteParam {
  const DashboardfavouriteRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}