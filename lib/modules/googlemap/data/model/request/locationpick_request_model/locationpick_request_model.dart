
import 'package:taxi_app/modules/googlemap/domain/params/locationpick_param.dart';

class LocationpickRequestModel extends LocationpickParam {
  const LocationpickRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}