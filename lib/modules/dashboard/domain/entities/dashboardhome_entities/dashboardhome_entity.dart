import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/top_location_entity.dart';

// class DashboardhomeEntity {
//   final String userMessage;
//   final bool status;

//   DashboardhomeEntity({
//     required this.userMessage,
//     required this.status,
//   });

//   DashboardhomeEntity copyWith({
//     String? userMessage,
//     bool? status,
//   }) {
//     return DashboardhomeEntity(
//       userMessage: userMessage ?? this.userMessage,
//       status: status ?? this.status,
//     );
//   }
// }


class DashboardhomeEntity extends Equatable {
  final List<PropertyEntity> recommended;
  final List<PropertyEntity> nearby;
  final List<TopLocationEntity> topLocations;
  final List<PropertyEntity> popularForYou;

  const DashboardhomeEntity({
    required this.recommended,
    required this.nearby,
    required this.topLocations,
    required this.popularForYou,
  });

  @override
  List<Object?> get props => [
        recommended,
        nearby,
        topLocations,
        popularForYou,
      ];
}