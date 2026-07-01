import 'package:taxi_app/modules/dashboard/data/model/response/dashboardhome_model/property_model.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardexplore_entity.dart';

import 'package:equatable/equatable.dart';

class DashboardexploreModel extends Equatable {
  final List<PropertyModel>? data;

  const DashboardexploreModel({this.data});

  factory DashboardexploreModel.fromJson(Map<String, dynamic> json) {
    return DashboardexploreModel(
      data: (json['data'] as List?)
          ?.map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory DashboardexploreModel.fromList(List<dynamic> json) {
    return DashboardexploreModel(
      data: json
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data?.map((e) => e.toJson()).toList()};
  }

  DashboardexploreModel copyWith({List<PropertyModel>? data}) {
    return DashboardexploreModel(data: data ?? this.data);
  }

  DashboardexploreEntity toEntity() {
    return DashboardexploreEntity(
      data: data?.map((e) => e.toEntity()).toList() ?? [],
    );
  }

  @override
  List<Object?> get props => [data];
}
