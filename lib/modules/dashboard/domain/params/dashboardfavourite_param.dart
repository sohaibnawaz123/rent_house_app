import 'package:taxi_app/modules/dashboard/data/model/request/dashboardfavourite_request_model/dashboardfavourite_request_model.dart';

class DashboardfavouriteParam {
  final String token;
  final String email;

  const DashboardfavouriteParam({
    required this.token,
    required this.email,
  });

  DashboardfavouriteRequestModel toModel() => DashboardfavouriteRequestModel(
        token: token,
        email: email,
      );
}