import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/app_bar/app_appbar.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/component/text_field/label_text_field.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/login/login_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/widget/auth_header.dart';

class LoginView extends StatefulWidget {
  final LoginBloc bloc;
  const LoginView({super.key, required this.bloc});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
              title: 'Welcome Back !',
              subTitle:
                  'Sign in with your email and password or social media to continue',
            ),
            30.heightBox,
            FeildSection(),
            30.heightBox,
            AppButton(title: 'Sign In'),
            30.heightBox,
            Content(
              data: 'OR',
              textStyle: context.titleText.copyWith(
                color: AppColor.baseText,
                fontWeight: AppFontWeight.semiBold,
              ),
              alignment: TextAlign.center,
            ),
            30.heightBox,
            AppButton(
              title: 'Sign In with Google',
              buttonColor: AppColor.transparent,
              border: BorderSide(color: AppColor.btnBg, width: 1.5),
              fontColor: AppColor.btnBg,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              iconPath: AppAsset.google,
              iconSize: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}

class FeildSection extends StatefulWidget {
  const FeildSection({super.key});

  @override
  State<FeildSection> createState() => _FeildSectionState();
}

class _FeildSectionState extends State<FeildSection> {
  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LabelTextField(
          labelText: "Email",
          hintText: "Enter your email",
          keyboardType: TextInputType.emailAddress,
        ),
        20.heightBox,
        LabelTextField(
          labelText: "Password",
          hintText: "Enter your password",
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),
        20.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CheckRow(
              isChecked: isRemember,
              onTap: () {
                setState(() {
                  isRemember = !isRemember;
                });
              },
            ),
            Content(
              data: 'Forgot Password ?',
              textStyle: context.lightText.copyWith(
                color: AppColor.primary,
                fontWeight: AppFontWeight.light,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CheckRow extends StatefulWidget {
  final bool isChecked;
  final void Function()? onTap;
  const CheckRow({super.key, required this.isChecked, this.onTap});

  @override
  State<CheckRow> createState() => _CheckRowState();
}

class _CheckRowState extends State<CheckRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 20.h,
            height: 20.h,
            decoration: BoxDecoration(
              color: widget.isChecked ? AppColor.btnBg : AppColor.white,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: widget.isChecked
                    ? AppColor.transparent
                    : AppColor.baseText,
                width: 1.5,
              ),
            ),
            child: Visibility(
              visible: widget.isChecked,
              child: Icon(Icons.check, size: 16.h, color: AppColor.white),
            ),
          ),
          10.widthBox,
          Content(
            data: 'Remember me',
            textStyle: context.lightText.copyWith(
              color: AppColor.baseText,
              fontWeight: AppFontWeight.light,
            ),
          ),
        ],
      ),
    );
  }
}
