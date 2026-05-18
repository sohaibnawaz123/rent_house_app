part of 'locationpick_bloc.dart';

class LocationSuggestion extends Equatable {
  final String title;
  final String address;
  final double latitude;
  final double longitude;

  const LocationSuggestion({
    required this.title,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [title, address, latitude, longitude];
}

class LocationpickState extends Equatable {
  static const double karachiLatitude = 24.8607;
  static const double karachiLongitude = 67.0011;

  final LocationpickViewInitialParams initialParams;
  final ApiResponse<BaseEntity<LocationpickEntity>> locationpickResponse;
  final double selectedLatitude;
  final double selectedLongitude;
  final String selectedAddress;
  final String searchQuery;
  final List<LocationSuggestion> suggestions;
  final bool isResolvingAddress;
  final bool isSearching;
  final int selectedPlaceVersion;

  const LocationpickState({
    required this.initialParams,
    this.locationpickResponse = const ApiResponse.init(),
    this.selectedLatitude = karachiLatitude,
    this.selectedLongitude = karachiLongitude,
    this.selectedAddress = 'Move the map to choose your pickup location',
    this.searchQuery = '',
    this.suggestions = const [],
    this.isResolvingAddress = false,
    this.isSearching = false,
    this.selectedPlaceVersion = 0,
  });

  LocationpickState copyWith({
    LocationpickViewInitialParams? initialParams,
    ApiResponse<BaseEntity<LocationpickEntity>>? locationpickResponse,
    double? selectedLatitude,
    double? selectedLongitude,
    String? selectedAddress,
    String? searchQuery,
    List<LocationSuggestion>? suggestions,
    bool? isResolvingAddress,
    bool? isSearching,
    int? selectedPlaceVersion,
  }) {
    LocationpickState data = LocationpickState(
      initialParams: initialParams ?? this.initialParams,
      locationpickResponse: locationpickResponse ?? this.locationpickResponse,
      selectedLatitude: selectedLatitude ?? this.selectedLatitude,
      selectedLongitude: selectedLongitude ?? this.selectedLongitude,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      searchQuery: searchQuery ?? this.searchQuery,
      suggestions: suggestions ?? this.suggestions,
      isResolvingAddress: isResolvingAddress ?? this.isResolvingAddress,
      isSearching: isSearching ?? this.isSearching,
      selectedPlaceVersion: selectedPlaceVersion ?? this.selectedPlaceVersion,
    );
    Utils.logInfo(data.toString(), name: "Locationpick");
    return data;
  }

  @override
  List<Object?> get props => [
        initialParams,
        locationpickResponse,
        selectedLatitude,
        selectedLongitude,
        selectedAddress,
        searchQuery,
        suggestions,
        isResolvingAddress,
        isSearching,
        selectedPlaceVersion,
      ];

  @override
  String toString() {
    return 'LocationpickState(initialParams: $initialParams, locationpickResponse: ${locationpickResponse.toString()}, selectedLatitude: $selectedLatitude, selectedLongitude: $selectedLongitude, selectedAddress: $selectedAddress, searchQuery: $searchQuery, suggestions: ${suggestions.length}, isResolvingAddress: $isResolvingAddress, isSearching: $isSearching, selectedPlaceVersion: $selectedPlaceVersion)';
  }
}
