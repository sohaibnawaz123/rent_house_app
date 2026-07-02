import 'package:taxi_app/modules/activity/data/model/response/bookingreviews_model/bookingreviews_model.dart';
import 'package:taxi_app/modules/activity/domain/entities/propertydetail_entity.dart';

import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardhome_model/property_agent_model.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardhome_model/property_model.dart';

class PropertydetailModel extends Equatable {
  final PropertyModel? property;
  final AgentModel? host;
  final List<BookingreviewsModel>? reviews;

  const PropertydetailModel({this.property, this.host, this.reviews});

  factory PropertydetailModel.fromJson(Map<String, dynamic> json) {
    return PropertydetailModel(
      property: json['property'] != null
          ? PropertyModel.fromJson(json['property'] as Map<String, dynamic>)
          : null,
      host: json['host'] != null
          ? AgentModel.fromJson(json['host'] as Map<String, dynamic>)
          : null,
      reviews: (json['reviews'] as List?)
          ?.map((e) => BookingreviewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'property': property?.toJson(),
      'host': host?.toJson(),
      'reviews': reviews?.map((e) => e.toJson()).toList(),
    };
  }

  PropertydetailModel copyWith({
    PropertyModel? property,
    AgentModel? host,
    List<BookingreviewsModel>? reviews,
  }) {
    return PropertydetailModel(
      property: property ?? this.property,
      host: host ?? this.host,
      reviews: reviews ?? this.reviews,
    );
  }

  PropertydetailEntity toEntity() {
    return PropertydetailEntity(
      property: property?.toEntity(),
      host: host?.toEntity(),
      reviews: reviews?.map((e) => e.toEntity()).toList() ?? [],
    );
  }

  @override
  List<Object?> get props => [property, host, reviews];
}
