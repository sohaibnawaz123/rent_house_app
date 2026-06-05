import 'package:taxi_app/modules/googlemap/domain/entities/locationpick_entity.dart';

class DashboardrootViewInitialParams {
  final LocationpickEntity location;

  const DashboardrootViewInitialParams({required this.location});

  String get address => location.addressLine;
  double get lat => location.lat;
  double get lng => location.lon;

  // factory DashboardrootViewInitialParams.fromUri(Uri uri) {
  //   return DashboardrootViewInitialParams(address: '', lat: null, lng: null

  //   );
  // }
}
