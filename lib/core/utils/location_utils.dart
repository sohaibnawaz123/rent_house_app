import 'package:geolocator/geolocator.dart';

class CurrentLocationException implements Exception {
  final String message;

  const CurrentLocationException(this.message);

  @override
  String toString() => message;
}

Future<Position> pickCurrentLocation() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw const CurrentLocationException(
      'Please turn on location services and try again.',
    );
  }

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.denied) {
    throw const CurrentLocationException(
      'Location permission is required to use your current location.',
    );
  }

  if (permission == LocationPermission.deniedForever) {
    throw const CurrentLocationException(
      'Location permission is permanently denied. Enable it from app settings.',
    );
  }

  return Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
    ),
  );
}
