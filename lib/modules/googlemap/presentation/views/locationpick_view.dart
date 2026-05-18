import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/googlemap/presentation/blocs/locationpick/locationpick_bloc.dart';


class LocationpickView extends StatefulWidget {
  final LocationpickBloc bloc;
  const LocationpickView({
    super.key,
    required this.bloc,
  });

  @override
  State<LocationpickView> createState() => _LocationpickViewState();
}

class _LocationpickViewState extends State<LocationpickView> {
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

class GoogleMapBackground extends StatefulWidget {
  const GoogleMapBackground({super.key});

  @override
  State<GoogleMapBackground> createState() => _GoogleMapBackgroundState();
}

class _GoogleMapBackgroundState extends State<GoogleMapBackground> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}