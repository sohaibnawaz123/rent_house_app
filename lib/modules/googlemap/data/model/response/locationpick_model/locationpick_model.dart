import 'package:taxi_app/modules/googlemap/domain/entities/locationpick_entity.dart';

import 'package:equatable/equatable.dart';

class LocationpickModel extends Equatable {
  final int? id;
  final int? userId;
  final double? lat;
  final double? lon;
  final String? city;
  final String? state;
  final String? country;
  final String? zipcode;
  final String? addressline;
  final String? countrycode;
  final String? provincecode;
  final String? createdAt;
  final String? updatedAt;

  const LocationpickModel({
    this.id,
    this.userId,
    this.lat,
    this.lon,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.addressline,
    this.countrycode,
    this.provincecode,
    this.createdAt,
    this.updatedAt,
  });

  factory LocationpickModel.fromJson(Map<String, dynamic> json) {
    return LocationpickModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      lat: _toDouble(json['lat']),
      lon: _toDouble(json['lon']),
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      zipcode: json['zipcode'] as String?,
      addressline: json['addressline'] as String?,
      countrycode: json['countrycode'] as String?,
      provincecode: json['provincecode'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'lat': lat,
      'lon': lon,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipcode,
      'addressline': addressline,
      'countrycode': countrycode,
      'provincecode': provincecode,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  LocationpickModel copyWith({
    int? id,
    int? userId,
    double? lat,
    double? lon,
    String? city,
    String? state,
    String? country,
    String? zipcode,
    String? addressline,
    String? countrycode,
    String? provincecode,
    String? createdAt,
    String? updatedAt,
  }) {
    return LocationpickModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipcode: zipcode ?? this.zipcode,
      addressline: addressline ?? this.addressline,
      countrycode: countrycode ?? this.countrycode,
      provincecode: provincecode ?? this.provincecode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  LocationpickEntity toEntity() {
    return LocationpickEntity(
      id: id,
      userId: userId,
      lat: lat,
      lon: lon,
      city: city,
      state: state,
      country: country,
      zipcode: zipcode,
      addressline: addressline,
      countrycode: countrycode,
      provincecode: provincecode,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    lat,
    lon,
    city,
    state,
    country,
    zipcode,
    addressline,
    countrycode,
    provincecode,
    createdAt,
    updatedAt,
  ];
}
