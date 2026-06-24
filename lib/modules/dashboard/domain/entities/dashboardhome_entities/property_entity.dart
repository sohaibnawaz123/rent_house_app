import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_address_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_agent_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_detail_entity.dart';

class PropertyEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String propertyType;
  final String status;
  final double price;
  final double pricePerMonth;
  final String currency;
  final String pricePeriod;
  final bool isFeatured;
  final bool isRecommended;
  final int recommendationScore;
  final int viewsCount;
  final double rating;
  final int reviewsCount;
  final double distanceKm;
  final String image;
  final List<String> images;
  final AddressEntity? address;
  final PropertyDetailEntity? details;
  final AgentEntity? agent;

  const PropertyEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.propertyType,
    required this.status,
    required this.price,
    required this.pricePerMonth,
    required this.currency,
    required this.pricePeriod,
    required this.isFeatured,
    required this.isRecommended,
    required this.recommendationScore,
    required this.viewsCount,
    required this.rating,
    required this.reviewsCount,
    required this.distanceKm,
    required this.image,
    required this.images,
    this.address,
    this.details,
    this.agent,
  });

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
    address,
    details,
    agent,
  ];
}
