import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final double lat;
  final double lon;
  final String city;
  final String state;
  final String country;
  final String zipcode;
  final String addressline;

  const AddressEntity({
    required this.lat,
    required this.lon,
    required this.city,
    required this.state,
    required this.country,
    required this.zipcode,
    required this.addressline,
  });

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
