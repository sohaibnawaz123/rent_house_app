part of 'dashboardprofile_bloc.dart';

sealed class DashboardprofileEvent extends Equatable {}

class LoadDashboardprofileEvent extends DashboardprofileEvent {
  final DashboardprofileParam param;
  LoadDashboardprofileEvent(this.param);

  @override
  List<Object?> get props => [param];
}

class PickImageFromGallery extends DashboardprofileEvent {
  @override
  List<Object?> get props => [];
}
