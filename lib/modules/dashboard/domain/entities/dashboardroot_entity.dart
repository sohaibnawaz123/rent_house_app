import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/resource/app_asset.dart';

class DashboardrootEntity {
  final String userMessage;
  final bool status;

  DashboardrootEntity({required this.userMessage, required this.status});

  DashboardrootEntity copyWith({String? userMessage, bool? status}) {
    return DashboardrootEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}

enum NavItem { home, explore, favourite, booking, profile }

class NavItemEntity extends Equatable {
  final NavItem item;
  final String lable;
  final String iconPath;
  final String activeIconPath;

  const NavItemEntity({
    required this.item,
    required this.lable,
    required this.iconPath,
    required this.activeIconPath,
  });

  static final home = NavItemEntity(
    item: NavItem.home,
    lable: 'Home',
    iconPath: AppAsset.home,
    activeIconPath: AppAsset.homeActive,
  );
  static final explore = NavItemEntity(
    item: NavItem.explore,
    lable: 'Explore',
    iconPath: AppAsset.explore,
    activeIconPath: AppAsset.exploreActive,
  );
  static final favourite = NavItemEntity(
    item: NavItem.favourite,
    lable: 'Favourite',
    iconPath: AppAsset.favourite,
    activeIconPath: AppAsset.favouriteActive,
  );
  static final booking = NavItemEntity(
    item: NavItem.booking,
    lable: 'Booking',
    iconPath: AppAsset.booking,
    activeIconPath: AppAsset.bookingActive,
  );
  static final profile = NavItemEntity(
    item: NavItem.profile,
    lable: 'Profile',
    iconPath: AppAsset.profile,
    activeIconPath: AppAsset.profileActive,
  );

  static List<NavItemEntity> get allItems => [
    home,
    explore,
    favourite,
    booking,
    profile,
  ];

  @override
  List<Object?> get props => [item, lable, iconPath, activeIconPath];
}
