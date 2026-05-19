import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardroot/dashboardroot_bloc.dart';


class DashboardrootView extends StatefulWidget {
  final DashboardrootBloc bloc;
  const DashboardrootView({
    super.key,
    required this.bloc,
  });

  @override
  State<DashboardrootView> createState() => _DashboardrootViewState();
}

class _DashboardrootViewState extends State<DashboardrootView> {
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
