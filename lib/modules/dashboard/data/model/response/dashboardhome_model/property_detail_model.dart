import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_detail_entity.dart';

class PropertyDetailModel extends Equatable {
  final int? id;
  final int? propertyId;
  final int? bedrooms;
  final int? bathrooms;
  final int? areaSqft;
  final bool? parking;
  final bool? furnished;
  final String? createdAt;
  final String? updatedAt;

  const PropertyDetailModel({
    this.id,
    this.propertyId,
    this.bedrooms,
    this.bathrooms,
    this.areaSqft,
    this.parking,
    this.furnished,
    this.createdAt,
    this.updatedAt,
  });

  factory PropertyDetailModel.fromJson(Map<String, dynamic> json) {
    return PropertyDetailModel(
      id: json['id'] as int?,
      propertyId: json['property_id'] as int?,
      bedrooms: json['bedrooms'] as int?,
      bathrooms: json['bathrooms'] as int?,
      areaSqft: json['area_sqft'] as int?,
      parking: json['parking'] as bool?,
      furnished: json['furnished'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'property_id': propertyId,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area_sqft': areaSqft,
      'parking': parking,
      'furnished': furnished,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  PropertyDetailModel copyWith({
    int? id,
    int? propertyId,
    int? bedrooms,
    int? bathrooms,
    int? areaSqft,
    bool? parking,
    bool? furnished,
    String? createdAt,
    String? updatedAt,
  }) {
    return PropertyDetailModel(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      areaSqft: areaSqft ?? this.areaSqft,
      parking: parking ?? this.parking,
      furnished: furnished ?? this.furnished,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  PropertyDetailEntity toEntity() {
    return PropertyDetailEntity(
      id: id ?? 0,
      propertyId: propertyId ?? 0,
      bedrooms: bedrooms ?? 0,
      bathrooms: bathrooms ?? 0,
      areaSqft: areaSqft ?? 0,
      parking: parking ?? false,
      furnished: furnished ?? false,
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }

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
  ];
}
