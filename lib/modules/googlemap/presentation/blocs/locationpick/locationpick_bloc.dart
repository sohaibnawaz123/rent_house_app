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
  final LocationpickViewInitialParams initialParams;
  final LocationpickUseCase _useCase;
  Timer? _searchDebounce;

  LocationpickBloc(this.initialParams, this._useCase)
      : super(LocationpickState(initialParams: initialParams)) {
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
      final locations = await locationFromAddress(event.query);
      final suggestions = <LocationSuggestion>[];

      for (final location in locations.take(5)) {
        final address = await _addressFromCoordinates(
          location.latitude,
          location.longitude,
        );

        suggestions.add(
          LocationSuggestion(
            title: _titleFromAddress(address),
            address: address,
            latitude: location.latitude,
            longitude: location.longitude,
          ),
        );
      }

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

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
