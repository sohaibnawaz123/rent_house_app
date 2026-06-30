part of 'refreshtoken_bloc.dart';

sealed class RefreshtokenEvent {}

class  LoadRefreshtokenEvent extends RefreshtokenEvent {
  final RefreshtokenParam param;
   LoadRefreshtokenEvent(this.param);
}
