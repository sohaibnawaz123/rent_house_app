import 'package:flutter/material.dart';
import 'package:taxi_app/component/alert/app_dialog.dart';
import 'package:taxi_app/component/app_bar/app_appbar.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/status_tile/status_tile.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/component/text_field/label_text_field.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_snackBar.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/core/validator/validator.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/resetpassword/resetpassword_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/widget/auth_header.dart';

class ResetpasswordView extends StatefulWidget {
  final ResetpasswordBloc bloc;
  const ResetpasswordView({super.key, required this.bloc});

  @override
  State<ResetpasswordView> createState() => _ResetpasswordViewState();
}

class _ResetpasswordViewState extends State<ResetpasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
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
              title: 'Create New Password',
              subTitle: 'Please enter a new password to change',
            ),
            30.heightBox,
            Form(
              key: _formKey,
              child: FeildSection(
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          0,
          context.pagePadding.right,
          context.pagePadding.bottom,
        ),
        child: AppButton(
          buttonColor: AppColor.btnBg,
          title: 'Change password',
          onTap: () {
            if (_passwordController.text != _confirmPasswordController.text) {
              // Show error message if passwords do not match
              context.showSnackbar(
                message: 'Passwords do not match',
                type: StatusTileType.error,
                backgroundColor: AppColor.errorText,
              );
              return;
            }
            if (_formKey.currentState?.validate() ?? false) {
              appDialog(context, SuccessReset());
            }
          },
        ),
      ),
    );
  }
}

class FeildSection extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const FeildSection({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
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
          controller: widget.passwordController,
          labelText: "New Password",
          hintText: "New password must be at least 8 characters",
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) => Validator.validatePassword(value ?? ''),
        ),
        20.heightBox,
        LabelTextField(
          controller: widget.confirmPasswordController,
          labelText: "Confim Password",
          hintText: "Re-enter your new password",
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) => Validator.validatePassword(value ?? ''),
        ),
      ],
    );
  }
}

class SuccessReset extends StatelessWidget {
  const SuccessReset({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      // height: MediaQuery.sizeOf(context).h * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage.svg(svgPath: AppAsset.success, size: 150),
            30.heightBox,
            Content(
              data: "Success!",
              alignment: TextAlign.center,
              textStyle: context.bodyText.copyWith(
                color: AppColor.primaryText,
                fontWeight: AppFontWeight.bold,
              ),
              size: 24,
            ),
            20.heightBox,

            Content(
              data: "Your password has been successfully reset",
              alignment: TextAlign.center,
              textStyle: context.bodyText.copyWith(color: AppColor.baseText),
            ),
            20.heightBox,
            AppButton(title: "Continue", buttonColor: AppColor.btnBg,onTap: (){
              context.popPage();
              context.popPage();
              context.popPage();
              context.popPage();
            },),
          ],
        ),
      ),
    );
  }
}
