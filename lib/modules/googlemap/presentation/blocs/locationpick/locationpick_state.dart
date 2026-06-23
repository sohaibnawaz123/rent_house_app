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
  final LocationpickModel selectedLocation;
  final String searchQuery;
  final List<LocationSuggestion> suggestions;
  final bool isResolvingAddress;
  final bool isSearching;
  final int selectedPlaceVersion;

  const LocationpickState({
    required this.initialParams,
    this.locationpickResponse = const ApiResponse.init(),
    this.selectedLocation = const LocationpickModel(
      lat: karachiLatitude,
      lon: karachiLongitude,
      city: 'Karachi',
      state: 'Sindh',
      country: 'Pakistan',
      zipcode: "",
      addressline: "",
      countrycode: "",
      provincecode: ""
    ),
    this.searchQuery = '',
    this.suggestions = const [],
    this.isResolvingAddress = false,
    this.isSearching = false,
    this.selectedPlaceVersion = 0,
  });

  LocationpickState copyWith({
    LocationpickViewInitialParams? initialParams,
    ApiResponse<BaseEntity<LocationpickEntity>>? locationpickResponse,
    LocationpickModel? selectedLocation,
    String? searchQuery,
    List<LocationSuggestion>? suggestions,
    bool? isResolvingAddress,
    bool? isSearching,
    int? selectedPlaceVersion,
  }) {
    LocationpickState data = LocationpickState(
      initialParams: initialParams ?? this.initialParams,
      locationpickResponse: locationpickResponse ?? this.locationpickResponse,
      selectedLocation: selectedLocation ?? this.selectedLocation,
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
    selectedLocation,
    searchQuery,
    suggestions,
    isResolvingAddress,
    isSearching,
    selectedPlaceVersion,
  ];

  @override
  String toString() {
    return 'LocationpickState(initialParams: $initialParams, locationpickResponse: ${locationpickResponse.toString()}, selectedLocation: $selectedLocation, searchQuery: $searchQuery, suggestions: ${suggestions.length}, isResolvingAddress: $isResolvingAddress, isSearching: $isSearching, selectedPlaceVersion: $selectedPlaceVersion)';
  }
}
