import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardhome_model/property_address_model.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardhome_model/property_agent_model.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardhome_model/property_detail_model.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_entity.dart';

class PropertyModel extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? propertyType;
  final String? status;
  final double? price;
  final double? pricePerMonth;
  final String? currency;
  final String? pricePeriod;
  final bool? isFeatured;
  final bool? isRecommended;
  final int? recommendationScore;
  final int? viewsCount;
  final double? rating;
  final int? reviewsCount;
  final double? distanceKm;
  final String? image;
  final List<String>? images;
  final List<String>? publicFacilities;
  final AddressModel? address;
  final PropertyDetailModel? details;
  final AgentModel? agent;

  const PropertyModel({
    this.id,
    this.name,
    this.description,
    this.propertyType,
    this.status,
    this.price,
    this.pricePerMonth,
    this.currency,
    this.pricePeriod,
    this.isFeatured,
    this.isRecommended,
    this.recommendationScore,
    this.viewsCount,
    this.rating,
    this.reviewsCount,
    this.distanceKm,
    this.image,
    this.images,
    this.publicFacilities,
    this.address,
    this.details,
    this.agent,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      propertyType: json['property_type'],
      status: json['status'],
      price: (json['price'] as num?)?.toDouble(),
      pricePerMonth: (json['price_per_month'] as num?)?.toDouble(),
      currency: json['currency'],
      pricePeriod: json['price_period'],
      isFeatured: json['is_featured'],
      isRecommended: json['is_recommended'],
      recommendationScore: json['recommendation_score'],
      viewsCount: json['views_count'],
      rating: (json['rating'] as num?)?.toDouble(),
      reviewsCount: json['reviews_count'],
      distanceKm: (json['distance_km'] as num?)?.toDouble(),
      image: json['image'],
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      publicFacilities: (json['public_facilities'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
      details: json['details'] != null
          ? PropertyDetailModel.fromJson(json['details'])
          : null,
      agent: json['agent'] != null ? AgentModel.fromJson(json['agent']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'property_type': propertyType,
      'status': status,
      'price': price,
      'price_per_month': pricePerMonth,
      'currency': currency,
      'price_period': pricePeriod,
      'is_featured': isFeatured,
      'is_recommended': isRecommended,
      'recommendation_score': recommendationScore,
      'views_count': viewsCount,
      'rating': rating,
      'reviews_count': reviewsCount,
      'distance_km': distanceKm,
      'image': image,
      'images': images,
      'public_facilities': publicFacilities,
      'address': address?.toJson(),
      'details': details?.toJson(),
      'agent': agent?.toJson(),
    };
  }

  PropertyModel copyWith({
    int? id,
    String? name,
    String? description,
    String? propertyType,
    String? status,
    double? price,
    double? pricePerMonth,
    String? currency,
    String? pricePeriod,
    bool? isFeatured,
    bool? isRecommended,
    int? recommendationScore,
    int? viewsCount,
    double? rating,
    int? reviewsCount,
    double? distanceKm,
    String? image,
    List<String>? images,
    List<String>? publicFacilities,
    AddressModel? address,
    PropertyDetailModel? details,
    AgentModel? agent,
  }) {
    return PropertyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      propertyType: propertyType ?? this.propertyType,
      status: status ?? this.status,
      price: price ?? this.price,
      pricePerMonth: pricePerMonth ?? this.pricePerMonth,
      currency: currency ?? this.currency,
      pricePeriod: pricePeriod ?? this.pricePeriod,
      isFeatured: isFeatured ?? this.isFeatured,
      isRecommended: isRecommended ?? this.isRecommended,
      recommendationScore: recommendationScore ?? this.recommendationScore,
      viewsCount: viewsCount ?? this.viewsCount,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      distanceKm: distanceKm ?? this.distanceKm,
      image: image ?? this.image,
      images: images ?? this.images,
      publicFacilities: publicFacilities ?? this.publicFacilities,
      address: address ?? this.address,
      details: details ?? this.details,
      agent: agent ?? this.agent,
    );
  }

  PropertyEntity toEntity() {
    return PropertyEntity(
      id: id ?? 0,
      name: name ?? '',
      description: description ?? '',
      propertyType: propertyType ?? '',
      status: status ?? '',
      price: price ?? 0,
      pricePerMonth: pricePerMonth ?? 0,
      currency: currency ?? '',
      pricePeriod: pricePeriod ?? '',
      isFeatured: isFeatured ?? false,
      isRecommended: isRecommended ?? false,
      recommendationScore: recommendationScore ?? 0,
      viewsCount: viewsCount ?? 0,
      rating: rating ?? 0,
      reviewsCount: reviewsCount ?? 0,
      distanceKm: distanceKm ?? 0,
      image: image ?? '',
      images: images ?? [],
      publicFacilities: publicFacilities ?? [],
      address: address?.toEntity(),
      details: details?.toEntity(),
      agent: agent?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    propertyType,
    status,
    price,
    pricePerMonth,
    currency,
    pricePeriod,
    isFeatured,
    isRecommended,
    recommendationScore,
    viewsCount,
    rating,
    reviewsCount,
    distanceKm,
    image,
    images,
    publicFacilities,
    address,
    details,
    agent,
  ];
}
