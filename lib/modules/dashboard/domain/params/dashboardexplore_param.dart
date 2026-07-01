import 'package:taxi_app/modules/dashboard/data/model/request/dashboardexplore_request_model/dashboardexplore_request_model.dart';

class DashboardexploreParam {
  final String token;
  final String type;

  const DashboardexploreParam({
    required this.token,
    required this.type,
  });

  DashboardexploreRequestModel toModel() => DashboardexploreRequestModel(
        token: token,
        type: type,
      );
}