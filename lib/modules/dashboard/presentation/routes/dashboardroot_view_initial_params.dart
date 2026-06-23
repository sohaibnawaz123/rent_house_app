import 'package:taxi_app/modules/googlemap/data/model/response/locationpick_model/locationpick_model.dart';

class DashboardrootViewInitialParams {
  final LocationpickModel location;

  const DashboardrootViewInitialParams({required this.location});

  String get address => location.addressline ??"";
  double get lat => location.lat??0.0;
  double get lng => location.lon??0.0;

  // factory DashboardrootViewInitialParams.fromUri(Uri uri) {
  //   return DashboardrootViewInitialParams(address: '', lat: null, lng: null

  //   );
  // }
}
