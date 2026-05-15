import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/app_appbar.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/status_tile/status_tile.dart';
import 'package:taxi_app/component/text_field/label_text_field.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_snackBar.dart';
import 'package:taxi_app/core/validator/validator.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/forgetpassword/forgetpassword_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/otpverification/otpverification_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/routes/otpverification_view_initial_params.dart';
import 'package:taxi_app/modules/auth/presentation/views/otpverification_view.dart';
import 'package:taxi_app/modules/auth/presentation/widget/auth_header.dart';
import 'package:taxi_app/modules/auth/presentation/widget/phone_email_card.dart';

class ForgetpasswordView extends StatefulWidget {
  final ForgetpasswordBloc bloc;
  final bool hasEmail;
  final String? email;
  const ForgetpasswordView({
    super.key,
    required this.bloc,
    this.hasEmail = false,
    this.email,
  });

  @override
  State<ForgetpasswordView> createState() => _ForgetpasswordViewState();
}

class _ForgetpasswordViewState extends State<ForgetpasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedContactType;

  @override
  void dispose() {
    _emailController.dispose();
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
              title: 'Forgot Password',
              subTitle:
                  'Select which contact details should we use to reset your password',
            ),
            30.heightBox,
            if (!widget.hasEmail)
              Form(
                key: _formKey,
                child: FeildSection(emailController: _emailController),
              ),
            if (!widget.hasEmail) 20.heightBox,

            if (widget.hasEmail)
              EmailorPhoneCard(
                isSelected: selectedContactType == 'email',
                title: widget.email ?? "",
                type: 'email',
                icon: AppAsset.email,
                onTap: () {
                  setState(() {
                    selectedContactType = 'email';
                  });
                },
              ),
            if (widget.hasEmail) 20.heightBox,
            if (widget.hasEmail)
              EmailorPhoneCard(
                isSelected: selectedContactType == 'phone',
                title: "+92 321****154",
                type: 'phone',
                icon: AppAsset.phone,
                onTap: () {
                  setState(() {
                    selectedContactType = 'phone';
                  });
                },
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
          title: 'Continue',
          onTap: () {
            if (!widget.hasEmail) {
              if (_formKey.currentState?.validate() ?? false) {
                context.pushPage(
                  OtpverificationView(
                    bloc: getIt<OtpverificationBloc>(
                      param1: OtpverificationViewInitialParams(),
                    ),
                  ),
                );
                // Handle successful validation (login logic)
              }
            } else {
              if (selectedContactType != null) {
                context.pushPage(
                  OtpverificationView(
                    bloc: getIt<OtpverificationBloc>(
                      param1: OtpverificationViewInitialParams(),
                    ),
                  ),
                );
              } else {
                // Show error message or prompt user to select a contact type
                context.showSnackbar(
                  backgroundColor: AppColor.errorText,
                  message: "Select to option to reset password",
                  type: StatusTileType.error,
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class FeildSection extends StatelessWidget {
  final TextEditingController emailController;
  const FeildSection({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return LabelTextField(
      controller: emailController,
      labelText: "Email",
      hintText: "Enter your email",
      keyboardType: TextInputType.emailAddress,
      validator: (value) => Validator.validateEmail(value ?? ''),
    );
  }
}
