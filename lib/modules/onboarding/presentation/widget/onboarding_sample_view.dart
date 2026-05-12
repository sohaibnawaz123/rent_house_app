import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

class OnboardingSampleModel {
  final String assetPath;
  final String heading;
  final String text;

  const OnboardingSampleModel({
    required this.assetPath,
    required this.heading,
    required this.text,
  });
}

class OnboardingSampleView extends StatelessWidget {
  final OnboardingSampleModel model;
  const OnboardingSampleView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //image part
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(context.pagePadding.top),
            child: AppImage.asset(
              assetPath:model.assetPath,
              size: double.infinity,
              fit: BoxFit.contain,
             
            ),
          ),
        ),
        //text part
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.pagePadding.horizontal,
              vertical: 20.h,
            ),
            child: Column(
              spacing: 20.h,
              children: [
                Content(
                  data: model.heading,
                  textStyle: context.headingText,
                  size: 28.sp,
                  alignment: TextAlign.center,
                  weight: AppFontWeight.bold,
                ),
                Content(
                  data: model.text,
                  textStyle: context.bodyText,
                  alignment: TextAlign.center,
                  size: 16.sp,
                  weight: AppFontWeight.medium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
