import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardprofile/dashboardprofile_bloc.dart';


class DashboardprofileView extends StatefulWidget {
  final DashboardprofileBloc bloc;
  const DashboardprofileView({
    super.key,
    required this.bloc,
  });

  @override
  State<DashboardprofileView> createState() => _DashboardprofileViewState();
}

class _DashboardprofileViewState extends State<DashboardprofileView> {
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
