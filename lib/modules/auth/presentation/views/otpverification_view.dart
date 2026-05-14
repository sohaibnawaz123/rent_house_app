import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/app_appbar.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/otpverification/otpverification_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/widget/auth_header.dart';

class OtpverificationView extends StatefulWidget {
  final OtpverificationBloc bloc;
  const OtpverificationView({super.key, required this.bloc});

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
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          context.pagePadding.top,
          context.pagePadding.right,
          context.pagePadding.bottom,
        ),
        child: ListView(
          children: [
            AppAppbar(title: ''),
            30.heightBox,
            AuthHeader(
              title: 'Verify your Email',
              subTitle:
                  'Please enter 4 digit verification that have been sent to your email address',
            ),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
