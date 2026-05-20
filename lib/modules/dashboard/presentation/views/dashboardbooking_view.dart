import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardbooking/dashboardbooking_bloc.dart';


class DashboardbookingView extends StatefulWidget {
  final DashboardbookingBloc bloc;
  const DashboardbookingView({
    super.key,
    required this.bloc,
  });

  @override
  State<DashboardbookingView> createState() => _DashboardbookingViewState();
}

class _DashboardbookingViewState extends State<DashboardbookingView> {
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
