import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/recent/recent_bloc.dart';


class RecentView extends StatefulWidget {
  final RecentBloc bloc;
  const RecentView({
    super.key,
    required this.bloc,
  });

  @override
  State<RecentView> createState() => _RecentViewState();
}

class _RecentViewState extends State<RecentView> {
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
