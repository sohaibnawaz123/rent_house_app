import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardhome_model/property_model.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardhome_model/top_location_model.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/dashboardhome_entity.dart';


class DashboardhomeModel extends Equatable {
  final List<PropertyModel>? recommended;
  final List<PropertyModel>? nearby;
  final List<TopLocationModel>? topLocations;
  final List<PropertyModel>? popularForYou;

  const DashboardhomeModel({
    this.recommended,
    this.nearby,
    this.topLocations,
    this.popularForYou,
  });

  factory DashboardhomeModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DashboardhomeModel(
      recommended: (json['recommended'] as List?)
          ?.map(
            (e) => PropertyModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      nearby: (json['nearby'] as List?)
          ?.map(
            (e) => PropertyModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      topLocations: (json['top_locations'] as List?)
          ?.map(
            (e) => TopLocationModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      popularForYou: (json['popular_for_you'] as List?)
          ?.map(
            (e) => PropertyModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recommended':
          recommended?.map((e) => e.toJson()).toList(),
      'nearby': nearby?.map((e) => e.toJson()).toList(),
      'top_locations':
          topLocations?.map((e) => e.toJson()).toList(),
      'popular_for_you':
          popularForYou?.map((e) => e.toJson()).toList(),
    };
  }

  DashboardhomeModel copyWith({
    List<PropertyModel>? recommended,
    List<PropertyModel>? nearby,
    List<TopLocationModel>? topLocations,
    List<PropertyModel>? popularForYou,
  }) {
    return DashboardhomeModel(
      recommended: recommended ?? this.recommended,
      nearby: nearby ?? this.nearby,
      topLocations: topLocations ?? this.topLocations,
      popularForYou: popularForYou ?? this.popularForYou,
    );
  }

  DashboardhomeEntity toEntity() {
    return DashboardhomeEntity(
      recommended:
          recommended?.map((e) => e.toEntity()).toList() ?? [],
      nearby:
          nearby?.map((e) => e.toEntity()).toList() ?? [],
      topLocations:
          topLocations?.map((e) => e.toEntity()).toList() ?? [],
      popularForYou:
          popularForYou?.map((e) => e.toEntity()).toList() ?? [],
    );
  }

  @override
  List<Object?> get props => [
        recommended,
        nearby,
        topLocations,
        popularForYou,
      ];
}