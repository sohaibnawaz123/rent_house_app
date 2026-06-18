// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text_field/label_text_field.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/profile_image_widget.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/editprofile/editprofile_bloc.dart';

class EditprofileView extends StatefulWidget {
  final EditprofileBloc bloc;
  const EditprofileView({super.key, required this.bloc});

  @override
  State<EditprofileView> createState() => _EditprofileViewState();
}

class _EditprofileViewState extends State<EditprofileView> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  String dob = '';
  @override
  void initState() {
    super.initState();
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // default selected date
      firstDate: DateTime(1900), // minimum date
      lastDate: DateTime(2100), // maximum date

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primary, // ✅ selected date background
              onPrimary: Colors.white, // ✅ selected date text
              onSurface: AppColor.primary, // normal text
            ),

            datePickerTheme: DatePickerThemeData(
              todayForegroundColor: MaterialStateProperty.all(
                AppColor.primary,
              ), // ✅ today text
              todayBackgroundColor: MaterialStateProperty.all(
                Colors.transparent,
              ), // ✅ no white bg
            ),

            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formatted = "${picked.day}/${picked.month}/${picked.year}";

      setState(() {
        dob = formatted;
        _dob.text = formatted; // ✅ IMPORTANT
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    // // print(bottomInset);
    // final bottomSpacing = bottomInset > 0 ? bottomInset + 40 : 110.0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.base,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          context.pagePadding.top - 20,
          context.pagePadding.left,
          // context.pagePadding.bottom,0
          0,
        ),
        child: ListView(
          children: [
            HeaderWidget(title: 'Edit Profile'),
            30.heightBox,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [AvaterWidget()],
            ),
            30.heightBox,

            LabelTextField(
              labelText: 'Full Name',
              // controller: _fullName,
              initialValue: widget.bloc.initialParams.fullname,
            ),
            20.heightBox,
            LabelTextField(
              labelText: 'Username',
              readOnly: true,
              initialValue: widget.bloc.initialParams.userName,
            ),
            20.heightBox,
            LabelTextField(
              labelText: 'Email',
              initialValue: widget.bloc.initialParams.email,
            ),
            20.heightBox,
            GestureDetector(
              onTap: () => pickDate(context),
              child: AbsorbPointer(
                child: LabelTextField(
                  readOnly: true,
                  controller: _dob,
                  labelText: 'Date of Birth',
                  suffixIcon: AppImage.svg(svgPath: AppAsset.clander, size: 24),
                ),
              ),
            ),
            20.heightBox,

            // bottomSpacing.heightBox,
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          // context.pagePadding.top - 20,
          0,
          context.pagePadding.left,
          context.pagePadding.bottom,
          // 0,
        ),
        child: AppButton(
          title: 'Save Changes',
          onTap: () {
            context.popPage();
          },
        ),
      ),
    );
  }
}
