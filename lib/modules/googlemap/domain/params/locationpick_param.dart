import 'package:taxi_app/modules/googlemap/data/model/request/locationpick_request_model/locationpick_request_model.dart';

class LocationpickParam {
  final double lat;
  final double lon;
  final String? city;
  final String? state;
  final String? country;
  final String? zipcode;
  final String? addressline;
  final String? countrycode;
  final String? provincecode;

  const LocationpickParam({
    required this.lat,
    required this.lon,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.addressline,
    this.countrycode,
    this.provincecode,
  });

  LocationpickRequestModel toModel() => LocationpickRequestModel(
    lat: lat,
    lon: lon,
    city: city,
    state: state,
    country: country,
    zipcode: zipcode,
    addressline: addressline,
    countrycode: countrycode,
    provincecode: provincecode,
  );
}
