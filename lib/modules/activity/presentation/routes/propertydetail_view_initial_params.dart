class PropertydetailViewInitialParams {
  final int? propertyId;
  const PropertydetailViewInitialParams({required this.propertyId});

  factory PropertydetailViewInitialParams.fromUri(Uri uri) {
    return PropertydetailViewInitialParams(
      propertyId: int.tryParse(uri.queryParameters['propertyId'] ?? ''),
      // Parse the URI parameters as needed
    );
  }
}
