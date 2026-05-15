
import 'package:taxi_app/modules/googlemap/domain/params/locationselection_param.dart';

class LocationselectionRequestModel extends LocationselectionParam {
  const LocationselectionRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}