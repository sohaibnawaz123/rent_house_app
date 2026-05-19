part of 'dashboardroot_bloc.dart';

sealed class DashboardrootEvent {}

class  LoadDashboardrootEvent extends DashboardrootEvent {
  final DashboardrootParam param;
   LoadDashboardrootEvent(this.param);
}
