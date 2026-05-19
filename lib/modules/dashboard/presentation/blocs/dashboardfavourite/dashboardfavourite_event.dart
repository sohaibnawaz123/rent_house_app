part of 'dashboardfavourite_bloc.dart';

sealed class DashboardfavouriteEvent {}

class  LoadDashboardfavouriteEvent extends DashboardfavouriteEvent {
  final DashboardfavouriteParam param;
   LoadDashboardfavouriteEvent(this.param);
}
