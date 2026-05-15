part of 'locationpick_bloc.dart';

sealed class LocationpickEvent {}

class  LoadLocationpickEvent extends LocationpickEvent {
  final LocationpickParam param;
   LoadLocationpickEvent(this.param);
}
