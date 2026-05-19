part of 'dashboardhome_bloc.dart';

sealed class DashboardhomeEvent {}

class  LoadDashboardhomeEvent extends DashboardhomeEvent {
  final DashboardhomeParam param;
   LoadDashboardhomeEvent(this.param);
}
