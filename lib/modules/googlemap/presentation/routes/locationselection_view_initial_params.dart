class LocationselectionViewInitialParams {
  final bool isPop;

  const LocationselectionViewInitialParams({this.isPop = false});

  factory LocationselectionViewInitialParams.fromUri(Uri uri) {
    return LocationselectionViewInitialParams(
      isPop: bool.tryParse(uri.queryParameters['isPop'] ?? '') ?? false,
    );
  }
}
