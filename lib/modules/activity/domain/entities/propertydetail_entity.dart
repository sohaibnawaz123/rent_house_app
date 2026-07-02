import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/activity/domain/entities/bookingreviews_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_agent_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_entity.dart';

class PropertydetailEntity extends Equatable {
  final PropertyEntity? property;
  final AgentEntity? host;
  final List<BookingreviewsEntity> reviews;

  const PropertydetailEntity({this.property, this.host, required this.reviews});

  @override
  List<Object?> get props => [property, host, reviews];
}
