import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardexplore/dashboardexplore_bloc.dart';


class DashboardexploreView extends StatefulWidget {
  final DashboardexploreBloc bloc;
  const DashboardexploreView({
    super.key,
    required this.bloc,
  });

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.base,

      
    );
  
  }
}
