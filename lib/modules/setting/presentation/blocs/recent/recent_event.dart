part of 'recent_bloc.dart';

sealed class RecentEvent {}

class  LoadRecentEvent extends RecentEvent {
  final RecentParam param;
   LoadRecentEvent(this.param);
}
