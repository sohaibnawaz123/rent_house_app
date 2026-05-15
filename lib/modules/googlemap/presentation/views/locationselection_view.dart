import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/googlemap/presentation/blocs/locationselection/locationselection_bloc.dart';


class LocationselectionView extends StatefulWidget {
  final LocationselectionBloc bloc;
  const LocationselectionView({
    super.key,
    required this.bloc,
  });

  @override
  State<LocationselectionView> createState() => _LocationselectionViewState();
}

class _LocationselectionViewState extends State<LocationselectionView> {
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
