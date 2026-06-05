import 'package:taxi_app/modules/googlemap/domain/params/locationpick_param.dart';

class LocationpickRequestModel extends LocationpickParam {
  const LocationpickRequestModel({
    required super.lat,
    required super.lon,
    required super.city,
    required super.state,
    required super.country,
    required super.zipCode,
    required super.addressLine,
    required super.countryCode,
    required super.provinceCode,
  });

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "city": city,
    "state": state,
    "country": country,
    "zip_code": zipCode,
    "address_line": addressLine,
    "country_code": countryCode,
    "province_code": provinceCode,
  };
}
