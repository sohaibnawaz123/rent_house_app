class LocationpickViewInitialParams {
  final double? latitude;
  final double? longitude;

  const LocationpickViewInitialParams({
    this.latitude,
    this.longitude,
  });

  factory LocationpickViewInitialParams.fromUri(Uri uri) {
    return LocationpickViewInitialParams(
      latitude: double.tryParse(uri.queryParameters['latitude'] ?? ''),
      longitude: double.tryParse(uri.queryParameters['longitude'] ?? ''),
    );
  }
}
