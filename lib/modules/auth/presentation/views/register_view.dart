import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/alert/app_dialog.dart';
import 'package:taxi_app/component/app_bar/app_appbar.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/status_tile/status_tile.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/component/text_field/label_text_field.dart';
import 'package:taxi_app/core/network/api_status.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_snackBar.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/core/validator/validator.dart';
import 'package:taxi_app/modules/auth/domain/params/register_param.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/register/register_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/widget/auth_header.dart';
import 'package:taxi_app/modules/auth/presentation/widget/checkbox_row.dart';

class RegisterView extends StatefulWidget {
  final RegisterBloc bloc;
  const RegisterView({super.key, required this.bloc});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isRemember = false;

  void _onRememberChanged(bool value) {
    setState(() {
      isRemember = value;
    });
  }

  void messagePopup({String? message, String? content}) {
    appDialog(
      context,
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: AppImage.svg(
              svgPath: AppAsset.success,
              size: MediaQuery.of(context).size.width - 200,
            ),
          ),
          20.heightBox,
          Content(
            data: message ?? "Message",
            textStyle: context.headingText,
            size: 22,
          ),
          20.heightBox,
          Content(
            data: content ?? "Content",
            textStyle: context.bodyText,
            alignment: TextAlign.center,
          ),
          20.heightBox,
          AppButton(
            onTap: () {
              context.popPage();
              context.popPage();
            },
            title: "Go Back",
          ),
        ],
      ),
    );
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
        child: BlocConsumer<RegisterBloc, RegisterState>(
          bloc: widget.bloc,
          listener: (context, state) {
            if (state.registerResponse.status == ApiStatus.completed) {
              // context.pushPage(
              //   LocationselectionView(
              //     bloc: getIt<LocationselectionBloc>(
              //       param1: LocationselectionViewInitialParams(),
              //     ),
              //   ),
              // );

              messagePopup(
                message: state.registerResponse.data?.message,
                content:
                    'Check you email and verify the email to login the app',
              );

              // context.showSnackbar(
              //   message:
              //       state.registerResponse.data?.message ??
              //       "Register Successfully",
              //   backgroundColor: AppColor.success,
              //   type: StatusTileType.success,
              // );
            }

            if (state.registerResponse.status == ApiStatus.error) {
              context.showSnackbar(
                message:
                    state.registerResponse.message ?? "Register Failed",
                backgroundColor: AppColor.error,
                type: StatusTileType.error,
              );
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                AppAppbar(title: ''),
                20.heightBox,
                AuthHeader(
                  title: 'Register Account',
                  subTitle:
                      'Sign in with your email and password or social media to continue',
                ),
                20.heightBox,
                Form(
                  key: _formKey,
                  child: FeildSection(
                    isRemember: isRemember,
                    onRememberChanged: _onRememberChanged,
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                ),
                20.heightBox,
                AppButton(
                  isDisable: state.registerResponse.status == ApiStatus.loading,
                  isLoading: state.registerResponse.status == ApiStatus.loading,
                  buttonColor: AppColor.btnBg,
                  title: 'Sign Up',
                  onTap: () {
                    if ((_formKey.currentState?.validate() == false)) {
                      context.showSnackbar(
                        message: ' Please agree with terms and privacy policy',
                        backgroundColor: AppColor.errorText,
                        type: StatusTileType.error,
                      );
                      return;
                    }
                    if (isRemember == false) {
                      context.showSnackbar(
                        message: ' Please agree with terms and privacy policy',
                        backgroundColor: AppColor.errorText,
                        type: StatusTileType.error,
                      );
                      return;
                    }

                    if ((_formKey.currentState?.validate() ?? false) &&
                        isRemember) {
                      widget.bloc.add(
                        LoadRegisterEvent(
                          RegisterParam(
                            email: _emailController.text,
                            username: _nameController.text,
                            password: _passwordController.text,
                            role: 'user',
                          ),
                        ),
                      );
                    }
                  },
                ),
                20.heightBox,
                Content(
                  data: 'OR',
                  textStyle: context.titleText.copyWith(
                    color: AppColor.baseText,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                  alignment: TextAlign.center,
                ),
                20.heightBox,
                AppButton(
                  title: 'Sign In with Google',
                  buttonColor: AppColor.transparent,
                  border: BorderSide(color: AppColor.btnBg, width: 1.5),
                  fontColor: AppColor.btnBg,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  iconPath: AppAsset.google,
                  iconSize: 20.h,
                ),
                20.heightBox,
                GestureDetector(
                  onTap: () => context.popPage(),
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
                          text: 'Sign In',
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
            );
          },
        ),
      ),
    );
  }
}

class FeildSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isRemember;
  final ValueChanged<bool> onRememberChanged;
  const FeildSection({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.isRemember,
    required this.onRememberChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextField(
          controller: nameController,
          labelText: "User Name",
          hintText: "Enter your user name",
          keyboardType: TextInputType.text,
          validator: (value) => Validator.validateFullName(value ?? '', 'Full'),
        ),
        10.heightBox,
        LabelTextField(
          controller: emailController,
          labelText: "Email",
          hintText: "Enter your email",
          keyboardType: TextInputType.emailAddress,
          validator: (value) => Validator.validateEmail(value ?? ''),
        ),
        10.heightBox,
        LabelTextField(
          controller: passwordController,
          labelText: "Password",
          hintText: "Enter your password",
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) => Validator.validatePassword(value ?? ''),
        ),
        20.heightBox,
        CheckRow(
          title: "Agree with terms and privacy policy",
          isChecked: isRemember,
          onTap: () {
            onRememberChanged(!isRemember);
          },
        ),
      ],
    );
  }
}
