part of 'dashboardbooking_bloc.dart';

sealed class DashboardbookingEvent {}

class  LoadDashboardbookingEvent extends DashboardbookingEvent {
  final DashboardbookingParam param;
   LoadDashboardbookingEvent(this.param);
}
