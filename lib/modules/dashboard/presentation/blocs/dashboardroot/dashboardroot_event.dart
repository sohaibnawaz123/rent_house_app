part of 'dashboardroot_bloc.dart';

sealed class DashboardrootEvent extends Equatable {
  const DashboardrootEvent();

  @override
  List<Object?> get props => [];
}

class ChangeNavigationEvent extends DashboardrootEvent {
  final NavItemEntity item;

  const ChangeNavigationEvent(this.item);
  @override
  List<Object?> get props => [item];
}

class InitializeNavigationEvent extends DashboardrootEvent {
  const InitializeNavigationEvent();
}
