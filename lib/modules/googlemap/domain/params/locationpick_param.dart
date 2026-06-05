import 'package:taxi_app/modules/googlemap/data/model/request/locationpick_request_model/locationpick_request_model.dart';

class LocationpickParam {
  final double? lat;
  final double? lon;
  final String? city;
  final String? state;
  final String? country;
  final String? zipCode;
  final String? addressLine;
  final String? countryCode;
  final String? provinceCode;

  const LocationpickParam({
    this.lat,
    this.lon,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.addressLine,
    this.countryCode,
    this.provinceCode,
  });

  LocationpickRequestModel toModel() => LocationpickRequestModel(
    lat: lat,
    lon: lon,
    city: city,
    state: state,
    country: country,
    zipCode: zipCode,
    addressLine: addressLine,
    countryCode: countryCode,
    provinceCode: provinceCode,
  );
}
