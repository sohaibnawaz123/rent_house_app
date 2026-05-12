import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/otpverification/otpverification_bloc.dart';


class OtpverificationView extends StatefulWidget {
  final OtpverificationBloc bloc;
  const OtpverificationView({
    super.key,
    required this.bloc,
  });

  @override
  State<OtpverificationView> createState() => _OtpverificationViewState();
}

class _OtpverificationViewState extends State<OtpverificationView> {
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
