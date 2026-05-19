
import 'package:taxi_app/modules/dashboard/domain/params/dashboardbooking_param.dart';

class DashboardbookingRequestModel extends DashboardbookingParam {
  const DashboardbookingRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}