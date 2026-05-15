import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:taxi_app/component/app_bar/app_appbar.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/status_tile/status_tile.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_snackBar.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/otpverification/otpverification_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/resetpassword/resetpassword_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/routes/resetpassword_view_initial_params.dart';
import 'package:taxi_app/modules/auth/presentation/views/resetpassword_view.dart';
import 'package:taxi_app/modules/auth/presentation/widget/auth_header.dart';

class OtpverificationView extends StatefulWidget {
  final OtpverificationBloc bloc;
  const OtpverificationView({super.key, required this.bloc});

  @override
  State<OtpverificationView> createState() => _OtpverificationViewState();
}

class _OtpverificationViewState extends State<OtpverificationView> {
  final TextEditingController _otpController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.white,
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
            OtpFeild(otpController: _otpController),
            30.heightBox,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Don’t receive code ?\n",
                style: context.lightText.copyWith(
                  color: AppColor.primaryText,
                  fontWeight: AppFontWeight.light,
                ),
                children: [
                  TextSpan(
                    text: 'Resend code',
                    style: context.bodyText.copyWith(
                      color: AppColor.errorText,
                      fontWeight: AppFontWeight.light,
                    ),
                  ),
                ],
              ),
            ),
            30.heightBox,
            AppButton(
              buttonColor: AppColor.btnBg,
              title: 'Verify',
              onTap: () {
                if (_otpController.text.isEmpty) {
                  context.showSnackbar(
                    message: 'OTP code cannot be empty',
                    type: StatusTileType.error,
                    backgroundColor: AppColor.errorText,
                  );
                } else if (_otpController.text.length < 5) {
                  context.showSnackbar(
                    message: 'Please enter a valid 5-digit OTP code',
                    type: StatusTileType.info,
                    backgroundColor: AppColor.primary,
                  );
                } else {
                  context.pushPage(
                    ResetpasswordView(
                      bloc: getIt<ResetpasswordBloc>(
                        param1: ResetpasswordViewInitialParams(),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OtpFeild extends StatelessWidget {
  final TextEditingController otpController;
  const OtpFeild({super.key, required this.otpController});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: otpController,
      // isCupertino: true,
      wrapAlignment: WrapAlignment.center,
      maxLength: 5,
      pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
      pinTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColor.primary,
      ),
      pinTextAnimatedSwitcherTransition:
          ProvidedPinBoxTextAnimation.scalingTransition,
      pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
      pinBoxRadius: 14,
      hasTextBorderColor: AppColor.primary,
      defaultBorderColor: AppColor.primary.withOpacity(0.4),
      errorBorderColor: AppColor.errorText,
      keyboardType: TextInputType.number,
      onTextChanged: (text) {
        // Handle text change
      },
      onDone: (text) {
        // Handle completion
      },
      pinBoxWidth: 56,
      pinBoxHeight: 56,
    );
  }
}
