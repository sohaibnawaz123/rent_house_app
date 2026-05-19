import 'package:taxi_app/modules/dashboard/data/model/request/dashboardbooking_request_model/dashboardbooking_request_model.dart';

class DashboardbookingParam {
  final String token;
  final String email;

  const DashboardbookingParam({
    required this.token,
    required this.email,
  });

  DashboardbookingRequestModel toModel() => DashboardbookingRequestModel(
        token: token,
        email: email,
      );
}