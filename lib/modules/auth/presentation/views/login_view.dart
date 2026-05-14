// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/app_bar/app_appbar.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/component/text_field/label_text_field.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/core/validator/validator.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/forgetpassword/forgetpassword_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/login/login_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/register/register_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/routes/forgetpassword_view_initial_params.dart';
import 'package:taxi_app/modules/auth/presentation/routes/register_view_initial_params.dart';
import 'package:taxi_app/modules/auth/presentation/views/forgetpassword_view.dart';
import 'package:taxi_app/modules/auth/presentation/views/register_view.dart';
import 'package:taxi_app/modules/auth/presentation/widget/auth_header.dart';
import 'package:taxi_app/modules/auth/presentation/widget/checkbox_row.dart';

class LoginView extends StatefulWidget {
  final LoginBloc bloc;
  const LoginView({super.key, required this.bloc});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isRemember = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
            Form(
              key: _formKey,
              child: FeildSection(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
            ),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CheckRow(
                  title: 'Remember me',
                  isChecked: isRemember,
                  onTap: () {
                    setState(() {
                      isRemember = !isRemember;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () => context.pushPage(
                    ForgetpasswordView(
                      hasEmail: _emailController.text.isNotEmpty,
                      email: _emailController.text.isNotEmpty
                          ? _emailController.text
                          : null,
                      bloc: getIt<ForgetpasswordBloc>(
                        param1: ForgetpasswordViewInitialParams(),
                      ),
                    ),
                  ),
                  child: Content(
                    data: 'Forgot Password ?',
                    textStyle: context.lightText.copyWith(
                      color: AppColor.primary,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                    size: 14,
                  ),
                ),
              ],
            ),
            30.heightBox,
            AppButton(
              buttonColor: AppColor.btnBg,
              title: 'Sign In',
              onTap: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Handle successful validation (login logic)
                }
              },
            ),
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
            30.heightBox,
            GestureDetector(
              onTap: () => context.pushPage(
                RegisterView(
                  bloc: getIt<RegisterBloc>(
                    param1: RegisterViewInitialParams(),
                  ),
                ),
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: context.lightText.copyWith(
                    color: AppColor.baseText,
                    fontWeight: AppFontWeight.light,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: context.bodyText.copyWith(
                        color: AppColor.primary,
                        fontWeight: AppFontWeight.light,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeildSection extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const FeildSection({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<FeildSection> createState() => _FeildSectionState();
}

class _FeildSectionState extends State<FeildSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LabelTextField(
          controller: widget.emailController,
          labelText: "Email",
          hintText: "Enter your email",
          keyboardType: TextInputType.emailAddress,
          validator: (value) => Validator.validateEmail(value ?? ''),
        ),
        20.heightBox,
        LabelTextField(
          controller: widget.passwordController,
          labelText: "Password",
          hintText: "Enter your password",
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) => Validator.validatePassword(value ?? ''),
        ),
      ],
    );
  }
}
