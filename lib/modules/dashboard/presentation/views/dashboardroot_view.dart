import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardroot_entity.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardbooking/dashboardbooking_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardexplore/dashboardexplore_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardfavourite/dashboardfavourite_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardhome/dashboardhome_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardprofile/dashboardprofile_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardroot/dashboardroot_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardbooking_view_initial_params.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardexplore_view_initial_params.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardfavourite_view_initial_params.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardhome_view_initial_params.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardprofile_view_initial_params.dart';
import 'package:taxi_app/modules/dashboard/presentation/views/dashboardbooking_view.dart';
import 'package:taxi_app/modules/dashboard/presentation/views/dashboardexplore_view.dart';
import 'package:taxi_app/modules/dashboard/presentation/views/dashboardfavourite_view.dart';
import 'package:taxi_app/modules/dashboard/presentation/views/dashboardhome_view.dart';
import 'package:taxi_app/modules/dashboard/presentation/views/dashboardprofile_view.dart';

class DashboardrootView extends StatefulWidget {
  final DashboardrootBloc bloc;
  const DashboardrootView({super.key, required this.bloc});

  @override
  State<DashboardrootView> createState() => _DashboardrootViewState();
}

class _DashboardrootViewState extends State<DashboardrootView> {
  late final DashboardhomeBloc _userHomeBloc;
  @override
  void initState() {
    super.initState();
    _userHomeBloc = getIt(
      param1: DashboardhomeViewInitialParams(
        address: widget.bloc.initialParams.address,
        lat: widget.bloc.initialParams.lat,
        lng: widget.bloc.initialParams.lng,
      ),
    );
    widget.bloc.add(const InitializeNavigationEvent());
  }

  @override
  void dispose() {
    _userHomeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.white,
        body: Stack(
          children: [
            _BodyContent(userHomeBloc: _userHomeBloc),
            Positioned(
              bottom: MediaQuery.of(context).viewPadding.bottom + 20,
              left: 20,
              right: 20,
              child: const _BottomNavigationBar(),
            ),
          ],
        ),
        // bottomNavigationBar: Padding(
        //   padding: EdgeInsets.only(
        //     bottom: MediaQuery.of(context).viewInsets.bottom,
        //   ),

        //   child: const _BottomNavigationBar(),
        // ),
      ),
    );
  }
}

class _BodyContent extends StatelessWidget {
  final DashboardhomeBloc userHomeBloc;
  const _BodyContent({required this.userHomeBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardrootBloc, DashboardrootState>(
      builder: (context, state) {
        return IndexedStack(
          index: state.currentItems.item.index,
          children: [
            DashboardhomeView(bloc: userHomeBloc),
            DashboardexploreView(
              bloc: getIt<DashboardexploreBloc>(
                param1: DashboardexploreViewInitialParams(),
              ),
            ),
            DashboardfavouriteView(
              bloc: getIt<DashboardfavouriteBloc>(
                param1: DashboardfavouriteViewInitialParams(),
              ),
            ),
            DashboardbookingView(
              bloc: getIt<DashboardbookingBloc>(
                param1: DashboardbookingViewInitialParams(),
              ),
            ),
            DashboardprofileView(
              bloc: getIt<DashboardprofileBloc>(
                param1: DashboardprofileViewInitialParams(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardrootBloc, DashboardrootState>(
      builder: (context, state) {
        // final bottomInset = MediaQuery.of(context).viewPadding.bottom;
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
              tileMode: TileMode.mirror,
            ),
            child: Container(
              height: 80.h,
              decoration: BoxDecoration(
                color: AppColor.black.withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              // padding: EdgeInsets.only(bottom: bottomInset),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: state.navItems.map((navItem) {
                  final isSelected = state.currentItems.item == navItem.item;
                  return _NavBarItem(
                    navItem: navItem,
                    isSelected: isSelected,
                    onTap: () {
                      context.read<DashboardrootBloc>().add(
                        ChangeNavigationEvent(navItem),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final NavItemEntity navItem;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.navItem,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isSelected
                  ? CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColor.white,
                      child: SvgPicture.asset(
                        navItem.activeIconPath,
                        width: 20.w,
                        height: 20.h,
                        // colorFilter: ColorFilter.mode(
                        //   isSelected ? AppColor.primary : AppColor.black,
                        //   BlendMode.srcIn,
                        // ),
                      ),
                    )
                  : SvgPicture.asset(
                      navItem.iconPath,
                      width: 24.w,
                      height: 24.h,
                      color: AppColor.black,
                      // colorFilter: ColorFilter.mode(
                      //   isSelected ? AppColor.primary : AppColor.black,
                      //   BlendMode.srcIn,
                      // ),
                    ),
              SizedBox(height: 4.h),
              Content(
                data: navItem.lable,
                size: 13,
                textStyle: context.bodyText,
                weight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColor.primary : AppColor.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
