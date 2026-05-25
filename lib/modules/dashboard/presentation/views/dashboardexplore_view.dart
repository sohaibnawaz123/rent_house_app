import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardroot_entity.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardexplore/dashboardexplore_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardroot/dashboardroot_bloc.dart';

class DashboardexploreView extends StatefulWidget {
  final DashboardexploreBloc bloc;
  final String? title;
  const DashboardexploreView({super.key, required this.bloc, this.title});

  @override
  State<DashboardexploreView> createState() => _DashboardexploreViewState();
}

class _DashboardexploreViewState extends State<DashboardexploreView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    // print(bottomInset);
    final bottomSpacing = bottomInset > 0 ? bottomInset + 40 : 110.0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          context.pagePadding.top - 20,
          context.pagePadding.left,
          // context.pagePadding.bottom,0
          0,
        ),
        child: ListView(
          children: [
            HeaderWidget(
              title: widget.title ?? 'Explore',
              onTap: () => context.read<DashboardrootBloc>().add(
                ChangeNavigationEvent(NavItemEntity.home),
              ),
            ),
            bottomSpacing.heightBox,
          ],
        ),
      ),
    );
  }
}
