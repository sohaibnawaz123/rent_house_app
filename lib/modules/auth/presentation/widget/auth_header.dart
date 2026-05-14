import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String? subTitle;
  const AuthHeader({super.key, required this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 10.h,
      children: [
        Content(
          data: title,
          textStyle: context.headingText.copyWith(
            color: AppColor.primaryText,
            fontWeight: AppFontWeight.semiBold,
          ),
          size: 28,
        ),
        if (subTitle != null)
          Content(
            data: subTitle ?? '',
            textStyle: context.bodyText.copyWith(
              color: AppColor.baseText,
              fontWeight: AppFontWeight.medium,
            ),
          ),
      ],
    );
  }
}
