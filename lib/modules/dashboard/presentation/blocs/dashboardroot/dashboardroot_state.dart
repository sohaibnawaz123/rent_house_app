part of 'dashboardroot_bloc.dart';

class DashboardrootState extends Equatable {
  final DashboardrootViewInitialParams initialParams;
  final List<NavItemEntity> navItems;
  final NavItemEntity currentItems;

  const DashboardrootState({
    required this.initialParams,
    required this.navItems,
    required this.currentItems,
  });

  factory DashboardrootState.initail(
    DashboardrootViewInitialParams initialParams,
  ) {
    return DashboardrootState(
      initialParams: initialParams,
      navItems: NavItemEntity.allItems,
      currentItems: NavItemEntity.home,
    );
  }

  DashboardrootState copyWith({
    DashboardrootViewInitialParams? initialParams,
    List<NavItemEntity>? navItems,
    NavItemEntity? currentItems,
  }) {
    DashboardrootState data = DashboardrootState(
      initialParams: initialParams ?? this.initialParams,
      navItems: navItems ?? this.navItems,
      currentItems: currentItems ?? this.currentItems,
    );
    Utils.logInfo(data.toString(), name: "Dashboardroot");
    return data;
  }

  @override
  List<Object?> get props => [initialParams, navItems, currentItems];

  @override
  String toString() {
    return 'UserRootState(initialParams: $initialParams, navItems: $navItems, currentNavItem: $currentItems)';
  }
}
