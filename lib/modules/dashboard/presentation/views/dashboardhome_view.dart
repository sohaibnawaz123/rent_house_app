import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardhome/dashboardhome_bloc.dart';


class DashboardhomeView extends StatefulWidget {
  final DashboardhomeBloc bloc;
  const DashboardhomeView({
    super.key,
    required this.bloc,
  });

  @override
  State<DashboardhomeView> createState() => _DashboardhomeViewState();
}

class _DashboardhomeViewState extends State<DashboardhomeView> {
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
