part of 'dashboardexplore_bloc.dart';

sealed class DashboardexploreEvent {}

class  LoadDashboardexploreEvent extends DashboardexploreEvent {
  final DashboardexploreParam param;
   LoadDashboardexploreEvent(this.param);
}
