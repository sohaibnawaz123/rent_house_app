import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_entity.dart';

class DashboardexploreEntity extends Equatable {
  final List<PropertyEntity> data;

  const DashboardexploreEntity({required this.data});

  DashboardexploreEntity copyWith({List<PropertyEntity>? data}) {
    return DashboardexploreEntity(data: data ?? this.data);
  }

  @override
  List<Object?> get props => [data];
}
