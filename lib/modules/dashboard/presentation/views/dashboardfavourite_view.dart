import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardfavourite/dashboardfavourite_bloc.dart';


class DashboardfavouriteView extends StatefulWidget {
  final DashboardfavouriteBloc bloc;
  const DashboardfavouriteView({
    super.key,
    required this.bloc,
  });

  @override
  State<DashboardfavouriteView> createState() => _DashboardfavouriteViewState();
}

class _DashboardfavouriteViewState extends State<DashboardfavouriteView> {
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
