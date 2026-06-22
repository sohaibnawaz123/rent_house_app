import 'package:taxi_app/modules/googlemap/domain/params/locationpick_param.dart';

class LocationpickRequestModel extends LocationpickParam {
  const LocationpickRequestModel({
    required super.lat,
    required super.lon,
    super.city,
    super.state,
    super.country,
    super.zipCode,
    super.addressLine,
    super.countryCode,
    super.provinceCode,
  });

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "city": city ?? "",
    "state": state ?? "",
    "country": country ?? "",
    "zip_code": zipCode ?? "",
    "address_line": addressLine ?? "",
    "country_code": countryCode ?? "",
    "province_code": provinceCode ?? "",
  };
}
