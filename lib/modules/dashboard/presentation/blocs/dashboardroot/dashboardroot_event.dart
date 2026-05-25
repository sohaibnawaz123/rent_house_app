part of 'dashboardroot_bloc.dart';

sealed class DashboardrootEvent extends Equatable {
  const DashboardrootEvent();

  @override
  List<Object?> get props => [];
}

class ChangeNavigationEvent extends DashboardrootEvent {
  final NavItemEntity item;
  final String? title;

  const ChangeNavigationEvent(this.item, {this.title});
  @override
  List<Object?> get props => [item, title];
}

class InitializeNavigationEvent extends DashboardrootEvent {
  const InitializeNavigationEvent();
}
