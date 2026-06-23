import 'package:taxi_app/modules/googlemap/domain/params/locationpick_param.dart';

class LocationpickRequestModel extends LocationpickParam {
  const LocationpickRequestModel({
    required super.lat,
    required super.lon,
    super.city,
    super.state,
    super.country,
    super.zipcode,
    super.addressline,
    super.countrycode,
    super.provincecode,
  });

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "city": city ?? "",
    "state": state ?? "",
    "country": country ?? "",
    "zipcode": zipcode ?? "",
    "addressline": addressline ?? "",
    "countrycode": countrycode ?? "",
    "provincecode": provincecode ?? "",
  };
}
