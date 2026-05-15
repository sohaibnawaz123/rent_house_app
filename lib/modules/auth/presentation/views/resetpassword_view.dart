import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/app_appbar.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/text_field/label_text_field.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
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
            if (_formKey.currentState?.validate() ?? false) {
              // Perform password reset logic here
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
