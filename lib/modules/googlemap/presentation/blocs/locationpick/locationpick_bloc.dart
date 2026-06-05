import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/entities/locationpick_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/params/locationpick_param.dart';
import 'package:taxi_app/modules/googlemap/domain/usecase/locationpick_use_case.dart';
import 'package:taxi_app/modules/googlemap/presentation/routes/locationpick_view_initial_params.dart';

part 'locationpick_event.dart';
part 'locationpick_state.dart';

class LocationpickBloc extends Bloc<LocationpickEvent, LocationpickState> {
  static const String _defaultCity = 'Karachi';
  static const String _defaultCountry = 'Pakistan';
  static const String _googleApiKey = 'AIzaSyB_98vor3r9WHfQCNdcffwY9BTtQNm_XdU';

  final LocationpickViewInitialParams initialParams;
  final LocationpickUseCase _useCase;
  Timer? _searchDebounce;

  LocationpickBloc(this.initialParams, this._useCase)
    : super(
        LocationpickState(
          initialParams: initialParams,
          selectedLocation: LocationpickEntity(
            lat: initialParams.latitude ?? LocationpickState.karachiLatitude,
            lon: initialParams.longitude ?? LocationpickState.karachiLongitude,
            city: _defaultCity,
            state: 'Sindh',
            country: _defaultCountry,
            zipCode: '',
            addressLine: 'Move the map to choose your pickup location',
            countryCode: 'PK',
            provinceCode: 'Sindh',
          ),
        ),
      ) {
    on<InitializeLocationpickEvent>(_initializeLocationpickAction);
    on<MapCameraMovedEvent>(_mapCameraMovedAction);
    on<MapCameraIdleEvent>(_mapCameraIdleAction);
    on<SearchQueryChangedEvent>(_searchQueryChangedAction);
    on<_SearchDebouncedLocationpickEvent>(_searchDebouncedAction);
    on<SearchSuggestionSelectedEvent>(_searchSuggestionSelectedAction);
    on<ClearLocationSearchEvent>(_clearLocationSearchAction);
    on<LoadLocationpickEvent>(_loadLocationpickAction);
  }

  Future<void> _initializeLocationpickAction(
    InitializeLocationpickEvent event,
    Emitter<LocationpickState> emit,
  ) async {
    emit(state.copyWith(isResolvingAddress: true));
    final location = await _locationFromCoordinates(
      state.selectedLocation.lat,
      state.selectedLocation.lon,
    );
    emit(state.copyWith(selectedLocation: location, isResolvingAddress: false));
  }

  void _mapCameraMovedAction(
    MapCameraMovedEvent event,
    Emitter<LocationpickState> emit,
  ) {
    final samePoint =
        (state.selectedLocation.lat - event.latitude).abs() < 0.00002 &&
        (state.selectedLocation.lon - event.longitude).abs() < 0.00002;

    if (samePoint) return;

    emit(
      state.copyWith(
        selectedLocation: state.selectedLocation.copyWith(
          lat: event.latitude,
          lon: event.longitude,
        ),
        isResolvingAddress: true,
      ),
    );
  }

  Future<void> _mapCameraIdleAction(
    MapCameraIdleEvent event,
    Emitter<LocationpickState> emit,
  ) async {
    final latitude = state.selectedLocation.lat;
    final longitude = state.selectedLocation.lon;
    final location = await _locationFromCoordinates(latitude, longitude);

    if (latitude != state.selectedLocation.lat ||
        longitude != state.selectedLocation.lon) {
      return;
    }

    emit(state.copyWith(selectedLocation: location, isResolvingAddress: false));
  }

  void _searchQueryChangedAction(
    SearchQueryChangedEvent event,
    Emitter<LocationpickState> emit,
  ) {
    _searchDebounce?.cancel();
    final query = event.query.trim();

    emit(
      state.copyWith(
        searchQuery: event.query,
        suggestions: const [],
        isSearching: query.isNotEmpty,
      ),
    );

    if (query.isEmpty) {
      emit(state.copyWith(isSearching: false));
      return;
    }

    _searchDebounce = Timer(
      const Duration(milliseconds: 450),
      () => add(_SearchDebouncedLocationpickEvent(query)),
    );
  }

  Future<void> _searchDebouncedAction(
    _SearchDebouncedLocationpickEvent event,
    Emitter<LocationpickState> emit,
  ) async {
    if (event.query != state.searchQuery.trim()) return;

    try {
      final suggestions = await _searchLocationSuggestions(event.query);

      if (event.query != state.searchQuery.trim()) return;

      emit(state.copyWith(suggestions: suggestions, isSearching: false));
    } catch (_) {
      emit(state.copyWith(suggestions: const [], isSearching: false));
    }
  }

  void _searchSuggestionSelectedAction(
    SearchSuggestionSelectedEvent event,
    Emitter<LocationpickState> emit,
  ) {
    emit(
      state.copyWith(
        selectedLocation: LocationpickEntity(
          lat: event.suggestion.latitude,
          lon: event.suggestion.longitude,
          city: '',
          state: '',
          country: _defaultCountry,
          zipCode: '',
          addressLine: event.suggestion.address,
          countryCode: 'PK',
          provinceCode: '',
        ),
        searchQuery: event.suggestion.address,
        suggestions: const [],
        isSearching: false,
        isResolvingAddress: false,
        selectedPlaceVersion: state.selectedPlaceVersion + 1,
      ),
    );
  }

  void _clearLocationSearchAction(
    ClearLocationSearchEvent event,
    Emitter<LocationpickState> emit,
  ) {
    _searchDebounce?.cancel();
    emit(
      state.copyWith(
        searchQuery: '',
        suggestions: const [],
        isSearching: false,
      ),
    );
  }

  Future<void> _loadLocationpickAction(
    LoadLocationpickEvent event,
    Emitter<LocationpickState> emit,
  ) async {
    emit(state.copyWith(locationpickResponse: ApiResponse.loading()));

    await _useCase
        .execute(event.param)
        .then(
          (value) => value.fold(
            (l) {
              emit(
                state.copyWith(
                  locationpickResponse: ApiResponse.error(l.error),
                ),
              );
            },
            (r) {
              emit(
                state.copyWith(locationpickResponse: ApiResponse.completed(r)),
              );
            },
          ),
        );
  }

  Future<LocationpickEntity> _locationFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isEmpty) {
        return _fallbackLocation(latitude, longitude);
      }

      final placemark = placemarks.first;
      final parts = [
        placemark.street,
        placemark.subLocality,
        placemark.locality,
        placemark.administrativeArea,
        placemark.country,
      ].where((part) => part != null && part.trim().isNotEmpty);

      final address = parts.join(', ');
      final addressLine = address.isEmpty ? '$latitude, $longitude' : address;

      return LocationpickEntity(
        lat: latitude,
        lon: longitude,
        city: _firstNotEmpty([
          placemark.locality,
          placemark.subAdministrativeArea,
          placemark.subLocality,
        ]),
        state: placemark.administrativeArea ?? '',
        country: placemark.country ?? '',
        zipCode: placemark.postalCode ?? '',
        addressLine: addressLine,
        countryCode: placemark.isoCountryCode ?? '',
        provinceCode: placemark.administrativeArea ?? '',
      );
    } catch (_) {
      return _fallbackLocation(latitude, longitude);
    }
  }

  LocationpickEntity _fallbackLocation(double latitude, double longitude) {
    return LocationpickEntity(
      lat: latitude,
      lon: longitude,
      city: '',
      state: '',
      country: '',
      zipCode: '',
      addressLine: '$latitude, $longitude',
      countryCode: '',
      provinceCode: '',
    );
  }

  String _firstNotEmpty(List<String?> values) {
    for (final value in values) {
      final text = value?.trim();
      if (text != null && text.isNotEmpty) {
        return text;
      }
    }
    return '';
  }

  String _titleFromAddress(String address) {
    final title = address.split(',').first.trim();
    return title.isEmpty ? address : title;
  }

  Future<List<LocationSuggestion>> _searchLocationSuggestions(
    String query,
  ) async {
    final placeSuggestions = await _searchGooglePlaces(query);
    if (placeSuggestions.isNotEmpty) {
      return placeSuggestions;
    }

    final searches = _localSearchQueries(query);
    final suggestionsByKey = <String, LocationSuggestion>{};

    for (final search in searches) {
      final locations = await _safeLocationFromAddress(search);

      for (final location in locations) {
        final entity = await _locationFromCoordinates(
          location.latitude,
          location.longitude,
        );
        final suggestion = LocationSuggestion(
          title: _titleFromAddress(entity.addressLine),
          address: entity.addressLine,
          latitude: location.latitude,
          longitude: location.longitude,
        );

        if (!_isPakistanResult(suggestion)) {
          continue;
        }

        suggestionsByKey[_locationKey(location)] = suggestion;
      }

      if (suggestionsByKey.length >= 5) break;
    }

    final suggestions = suggestionsByKey.values.toList()
      ..sort(
        (a, b) =>
            _suggestionScore(query, b).compareTo(_suggestionScore(query, a)),
      );

    return suggestions.take(5).toList();
  }

  Future<List<LocationSuggestion>> _searchGooglePlaces(String query) async {
    final autocompleteUri =
        Uri.https('maps.googleapis.com', '/maps/api/place/autocomplete/json', {
          'input': query,
          'key': _googleApiKey,
          'components': 'country:pk',
          'location':
              '${LocationpickState.karachiLatitude},'
              '${LocationpickState.karachiLongitude}',
          'radius': '80000',
          'strictbounds': 'false',
        });

    try {
      final response = await http.get(autocompleteUri);
      if (response.statusCode != 200) return const [];

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final status = body['status'] as String?;
      if (status != 'OK' && status != 'ZERO_RESULTS') return const [];

      final predictions = body['predictions'] as List<dynamic>? ?? const [];
      final suggestions = <LocationSuggestion>[];

      for (final prediction in predictions.take(5)) {
        if (prediction is! Map<String, dynamic>) continue;

        final placeId = prediction['place_id'] as String?;
        if (placeId == null || placeId.isEmpty) continue;

        final suggestion = await _googlePlaceSuggestionFromPlaceId(
          placeId: placeId,
          fallbackTitle:
              prediction['structured_formatting']?['main_text'] as String? ??
              prediction['description'] as String? ??
              query,
          fallbackAddress: prediction['description'] as String? ?? query,
        );

        if (suggestion == null || !_isPakistanResult(suggestion)) {
          continue;
        }

        suggestions.add(suggestion);
      }

      return _uniqueSuggestions(suggestions);
    } catch (_) {
      return const [];
    }
  }

  Future<LocationSuggestion?> _googlePlaceSuggestionFromPlaceId({
    required String placeId,
    required String fallbackTitle,
    required String fallbackAddress,
  }) async {
    final detailsUri =
        Uri.https('maps.googleapis.com', '/maps/api/place/details/json', {
          'place_id': placeId,
          'key': _googleApiKey,
          'fields': 'name,formatted_address,geometry',
        });

    try {
      final response = await http.get(detailsUri);
      if (response.statusCode != 200) return null;

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['status'] != 'OK') return null;

      final result = body['result'] as Map<String, dynamic>?;
      final location =
          result?['geometry']?['location'] as Map<String, dynamic>?;
      final latitude = _toDouble(location?['lat']);
      final longitude = _toDouble(location?['lng']);
      if (latitude == null || longitude == null) return null;

      final address =
          result?['formatted_address'] as String? ?? fallbackAddress;
      final title = result?['name'] as String? ?? fallbackTitle;

      return LocationSuggestion(
        title: title,
        address: address,
        latitude: latitude,
        longitude: longitude,
      );
    } catch (_) {
      return null;
    }
  }

  List<LocationSuggestion> _uniqueSuggestions(
    List<LocationSuggestion> suggestions,
  ) {
    final suggestionsByKey = <String, LocationSuggestion>{};
    for (final suggestion in suggestions) {
      suggestionsByKey['${suggestion.latitude.toStringAsFixed(5)},'
              '${suggestion.longitude.toStringAsFixed(5)}'] =
          suggestion;
    }
    return suggestionsByKey.values.take(5).toList();
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  List<String> _localSearchQueries(String query) {
    final normalizedQuery = query.toLowerCase();
    final hasCity = normalizedQuery.contains(_defaultCity.toLowerCase());
    final hasCountry = normalizedQuery.contains(_defaultCountry.toLowerCase());

    if (hasCity || hasCountry) {
      return [query];
    }

    return [
      '$query, $_defaultCity, $_defaultCountry',
      '$query, $_defaultCountry',
      query,
    ];
  }

  Future<List<Location>> _safeLocationFromAddress(String query) async {
    try {
      return locationFromAddress(query);
    } catch (_) {
      return const [];
    }
  }

  String _locationKey(Location location) {
    return '${location.latitude.toStringAsFixed(5)},'
        '${location.longitude.toStringAsFixed(5)}';
  }

  bool _isPakistanResult(LocationSuggestion suggestion) {
    final address = suggestion.address.toLowerCase();
    final inPakistanBounds =
        suggestion.latitude >= 23 &&
        suggestion.latitude <= 38 &&
        suggestion.longitude >= 60 &&
        suggestion.longitude <= 78;

    return address.contains('pakistan') || inPakistanBounds;
  }

  int _suggestionScore(String query, LocationSuggestion suggestion) {
    final text = '${suggestion.title} ${suggestion.address}'.toLowerCase();
    final normalizedQuery = query.toLowerCase();
    var score = 0;

    if (text.contains(normalizedQuery)) score += 6;
    if (text.contains(_defaultCity.toLowerCase())) score += 5;
    if (text.contains('sindh')) score += 3;
    if (text.contains(_defaultCountry.toLowerCase())) score += 4;
    if (_isNearKarachi(suggestion)) score += 4;

    return score;
  }

  bool _isNearKarachi(LocationSuggestion suggestion) {
    return suggestion.latitude >= 24.65 &&
        suggestion.latitude <= 25.15 &&
        suggestion.longitude >= 66.75 &&
        suggestion.longitude <= 67.45;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
