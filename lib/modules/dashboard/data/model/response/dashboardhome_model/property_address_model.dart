import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_address_entity.dart';

class AddressModel extends Equatable {
  final double? lat;
  final double? lon;
  final String? city;
  final String? state;
  final String? country;
  final String? zipcode;
  final String? addressline;

  const AddressModel({
    this.lat,
    this.lon,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.addressline,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      lat: double.tryParse(json['lat'].toString()),
      lon: double.tryParse(json['lon'].toString()),
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      zipcode: json['zipcode'] as String?,
      addressline: json['addressline'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipcode,
      'addressline': addressline,
    };
  }

  AddressModel copyWith({
    double? lat,
    double? lon,
    String? city,
    String? state,
    String? country,
    String? zipcode,
    String? addressline,
  }) {
    return AddressModel(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipcode: zipcode ?? this.zipcode,
      addressline: addressline ?? this.addressline,
    );
  }

  AddressEntity toEntity() {
    return AddressEntity(
      lat: lat ?? 0,
      lon: lon ?? 0,
      city: city ?? '',
      state: state ?? '',
      country: country ?? '',
      zipcode: zipcode ?? '',
      addressline: addressline ?? '',
    );
  }

  @override
  List<Object?> get props => [
    lat,
    lon,
    city,
    state,
    country,
    zipcode,
    addressline,
  ];
}
