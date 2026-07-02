import 'package:equatable/equatable.dart';

class PropertyDetailEntity extends Equatable {
  final int id;
  final int propertyId;
  final int bedrooms;
  final int bathrooms;
  final int areaSqft;
  final bool parking;
  final bool furnished;
  final String createdAt;
  final String updatedAt;
  final List<String> publicFacilities;

  const PropertyDetailEntity({
    required this.id,
    required this.propertyId,
    required this.bedrooms,
    required this.bathrooms,
    required this.areaSqft,
    required this.parking,
    required this.furnished,
    required this.createdAt,
    required this.updatedAt,
    required this.publicFacilities,
  });

  @override
  List<Object?> get props => [
    id,
    propertyId,
    bedrooms,
    bathrooms,
    areaSqft,
    parking,
    furnished,
    createdAt,
    updatedAt,
    publicFacilities
  ];
}
