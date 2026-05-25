part of 'dashboardroot_bloc.dart';

class DashboardrootState extends Equatable {
  final DashboardrootViewInitialParams initialParams;
  final List<NavItemEntity> navItems;
  final NavItemEntity currentItems;
  final String currentTitle;

  const DashboardrootState({
    required this.initialParams,
    required this.navItems,
    required this.currentItems,
    required this.currentTitle,
  });

  factory DashboardrootState.initail(
    DashboardrootViewInitialParams initialParams,
  ) {
    return DashboardrootState(
      initialParams: initialParams,
      navItems: NavItemEntity.allItems,
      currentItems: NavItemEntity.home,
      currentTitle: NavItemEntity.home.lable,
    );
  }

  DashboardrootState copyWith({
    DashboardrootViewInitialParams? initialParams,
    List<NavItemEntity>? navItems,
    NavItemEntity? currentItems,
    String? currentTitle,
  }) {
    DashboardrootState data = DashboardrootState(
      initialParams: initialParams ?? this.initialParams,
      navItems: navItems ?? this.navItems,
      currentItems: currentItems ?? this.currentItems,
      currentTitle: currentTitle ?? this.currentTitle,
    );
    Utils.logInfo(data.toString(), name: "Dashboardroot");
    return data;
  }

  @override
  List<Object?> get props => [
    initialParams,
    navItems,
    currentItems,
    currentTitle,
  ];

  @override
  String toString() {
    return 'UserRootState(initialParams: $initialParams, navItems: $navItems, currentNavItem: $currentItems, currentTitle: $currentTitle)';
  }
}
