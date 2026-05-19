part of 'dashboardprofile_bloc.dart';

sealed class DashboardprofileEvent {}

class  LoadDashboardprofileEvent extends DashboardprofileEvent {
  final DashboardprofileParam param;
   LoadDashboardprofileEvent(this.param);
}
