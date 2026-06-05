import 'package:equatable/equatable.dart';

class LocationpickEntity extends Equatable {
  final double lat;
  final double lon;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String addressLine;
  final String countryCode;
  final String provinceCode;

  const LocationpickEntity({
    required this.lat,
    required this.lon,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.addressLine,
    required this.countryCode,
    required this.provinceCode,
  });

  LocationpickEntity copyWith({
    double? lat,
    double? lon,
    String? city,
    String? state,
    String? country,
    String? zipCode,
    String? addressLine,
    String? countryCode,
    String? provinceCode,
  }) {
    return LocationpickEntity(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      addressLine: addressLine ?? this.addressLine,
      countryCode: countryCode ?? this.countryCode,
      provinceCode: provinceCode ?? this.provinceCode,
    );
  }

  @override
  List<Object?> get props => [
    lat,
    lon,
    city,
    state,
    country,
    zipCode,
    addressLine,
    countryCode,
    provinceCode,
  ];
}
