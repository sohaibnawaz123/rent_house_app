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

  factory LocationpickEntity.fromJson(Map<String, dynamic> json) {
    return LocationpickEntity(
      lat: _toDouble(json['lat']),
      lon: _toDouble(json['lon']),
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',
      zipCode: json['zipCode'] as String? ?? '',
      addressLine: json['addressLine'] as String? ?? '',
      countryCode: json['countryCode'] as String? ?? '',
      provinceCode: json['provinceCode'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lon': lon,
    'city': city,
    'state': state,
    'country': country,
    'zipCode': zipCode,
    'addressLine': addressLine,
    'countryCode': countryCode,
    'provinceCode': provinceCode,
  };

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

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
