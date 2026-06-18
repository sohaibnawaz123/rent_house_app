part of 'reserve_bloc.dart';

sealed class ReserveEvent {}

class  LoadReserveEvent extends ReserveEvent {
  final ReserveParam param;
   LoadReserveEvent(this.param);
}
