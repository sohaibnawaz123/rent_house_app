import 'package:taxi_app/modules/googlemap/domain/entities/locationpick_entity.dart';

class LocationpickModel {
  final double? lat;
  final double? lon;
  final String? city;
  final String? state;
  final String? country;
  final String? zipCode;
  final String? addressLine;
  final String? countryCode;
  final String? provinceCode;

  LocationpickModel({
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

  factory LocationpickModel.fromJson(Map<String, dynamic> json) =>
      LocationpickModel(
        lat: _toDouble(json['lat']),
        lon: _toDouble(json['lon']),
        city: json['city'],
        state: json['state'],
        country: json['country'],
        zipCode: json['zipCode'],
        addressLine: json['addressLine'],
        countryCode: json['countryCode'],
        provinceCode: json['provinceCode'],
      );

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
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

  LocationpickModel copyWith({
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
    return LocationpickModel(
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

  LocationpickEntity toEntity() {
    return LocationpickEntity(
      lat: lat ?? 0.0,
      lon: lon ?? 0.0,
      city: city ?? '',
      state: state ?? '',
      country: country ?? '',
      zipCode: zipCode ?? '',
      addressLine: addressLine ?? '',
      countryCode: countryCode ?? '',
      provinceCode: provinceCode ?? '',
    );
  }
}
