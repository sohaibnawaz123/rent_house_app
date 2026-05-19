import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
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

  final LocationpickViewInitialParams initialParams;
  final LocationpickUseCase _useCase;
  Timer? _searchDebounce;

  LocationpickBloc(this.initialParams, this._useCase)
      : super(
          LocationpickState(
            initialParams: initialParams,
            selectedLatitude:
                initialParams.latitude ?? LocationpickState.karachiLatitude,
            selectedLongitude:
                initialParams.longitude ?? LocationpickState.karachiLongitude,
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
    final address = await _addressFromCoordinates(
      state.selectedLatitude,
      state.selectedLongitude,
    );
    emit(
      state.copyWith(
        selectedAddress: address,
        isResolvingAddress: false,
      ),
    );
  }

  void _mapCameraMovedAction(
    MapCameraMovedEvent event,
    Emitter<LocationpickState> emit,
  ) {
    final samePoint =
        (state.selectedLatitude - event.latitude).abs() < 0.00002 &&
        (state.selectedLongitude - event.longitude).abs() < 0.00002;

    if (samePoint) return;

    emit(
      state.copyWith(
        selectedLatitude: event.latitude,
        selectedLongitude: event.longitude,
        isResolvingAddress: true,
      ),
    );
  }

  Future<void> _mapCameraIdleAction(
    MapCameraIdleEvent event,
    Emitter<LocationpickState> emit,
  ) async {
    final latitude = state.selectedLatitude;
    final longitude = state.selectedLongitude;
    final address = await _addressFromCoordinates(latitude, longitude);

    if (latitude != state.selectedLatitude ||
        longitude != state.selectedLongitude) {
      return;
    }

    emit(
      state.copyWith(
        selectedAddress: address,
        isResolvingAddress: false,
      ),
    );
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

      emit(
        state.copyWith(
          suggestions: suggestions,
          isSearching: false,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          suggestions: const [],
          isSearching: false,
        ),
      );
    }
  }

  void _searchSuggestionSelectedAction(
    SearchSuggestionSelectedEvent event,
    Emitter<LocationpickState> emit,
  ) {
    emit(
      state.copyWith(
        selectedLatitude: event.suggestion.latitude,
        selectedLongitude: event.suggestion.longitude,
        selectedAddress: event.suggestion.address,
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

    await _useCase.execute(event.param).then(
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

  Future<String> _addressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isEmpty) {
        return '$latitude, $longitude';
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
      return address.isEmpty ? '$latitude, $longitude' : address;
    } catch (_) {
      return '$latitude, $longitude';
    }
  }

  String _titleFromAddress(String address) {
    final title = address.split(',').first.trim();
    return title.isEmpty ? address : title;
  }

  Future<List<LocationSuggestion>> _searchLocationSuggestions(
    String query,
  ) async {
    final searches = _localSearchQueries(query);
    final suggestionsByKey = <String, LocationSuggestion>{};

    for (final search in searches) {
      final locations = await _safeLocationFromAddress(search);

      for (final location in locations) {
        final address = await _addressFromCoordinates(
          location.latitude,
          location.longitude,
        );
        final suggestion = LocationSuggestion(
          title: _titleFromAddress(address),
          address: address,
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
        (a, b) => _suggestionScore(query, b).compareTo(
          _suggestionScore(query, a),
        ),
      );

    return suggestions.take(5).toList();
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
    final inPakistanBounds = suggestion.latitude >= 23 &&
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
