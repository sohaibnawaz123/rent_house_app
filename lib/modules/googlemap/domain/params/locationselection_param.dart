import 'package:taxi_app/modules/googlemap/data/model/request/locationselection_request_model/locationselection_request_model.dart';

class LocationselectionParam {
  final String token;
  final String email;

  const LocationselectionParam({
    required this.token,
    required this.email,
  });

  LocationselectionRequestModel toModel() => LocationselectionRequestModel(
        token: token,
        email: email,
      );
}