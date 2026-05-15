part of 'locationselection_bloc.dart';

sealed class LocationselectionEvent {}

class  LoadLocationselectionEvent extends LocationselectionEvent {
  final LocationselectionParam param;
   LoadLocationselectionEvent(this.param);
}
