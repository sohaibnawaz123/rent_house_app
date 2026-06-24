class LocationpickViewInitialParams {
  final double? latitude;
  final double? longitude;
  final bool? isPop;

  const LocationpickViewInitialParams({
    this.latitude,
    this.longitude,
    this.isPop,
  });

  factory LocationpickViewInitialParams.fromUri(Uri uri) {
    return LocationpickViewInitialParams(
      isPop: bool.tryParse(uri.queryParameters["isPop"] ?? ""),
      latitude: double.tryParse(uri.queryParameters['latitude'] ?? ''),
      longitude: double.tryParse(uri.queryParameters['longitude'] ?? ''),
    );
  }
}
