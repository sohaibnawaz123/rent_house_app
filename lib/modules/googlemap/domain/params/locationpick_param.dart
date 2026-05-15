import 'package:taxi_app/modules/googlemap/data/model/request/locationpick_request_model/locationpick_request_model.dart';

class LocationpickParam {
  final String token;
  final String email;

  const LocationpickParam({
    required this.token,
    required this.email,
  });

  LocationpickRequestModel toModel() => LocationpickRequestModel(
        token: token,
        email: email,
      );
}