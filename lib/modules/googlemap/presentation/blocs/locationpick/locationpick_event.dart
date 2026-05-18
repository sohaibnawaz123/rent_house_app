part of 'locationpick_bloc.dart';

sealed class LocationpickEvent {}

class InitializeLocationpickEvent extends LocationpickEvent {}

class MapCameraMovedEvent extends LocationpickEvent {
  final double latitude;
  final double longitude;

  MapCameraMovedEvent({
    required this.latitude,
    required this.longitude,
  });
}

class MapCameraIdleEvent extends LocationpickEvent {}

class SearchQueryChangedEvent extends LocationpickEvent {
  final String query;

  SearchQueryChangedEvent(this.query);
}

class _SearchDebouncedLocationpickEvent extends LocationpickEvent {
  final String query;

  _SearchDebouncedLocationpickEvent(this.query);
}

class SearchSuggestionSelectedEvent extends LocationpickEvent {
  final LocationSuggestion suggestion;

  SearchSuggestionSelectedEvent(this.suggestion);
}

class ClearLocationSearchEvent extends LocationpickEvent {}

class LoadLocationpickEvent extends LocationpickEvent {
  final LocationpickParam param;

  LoadLocationpickEvent(this.param);
}
