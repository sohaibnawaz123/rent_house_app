import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/resource/app_text.dart';

extension AppTextStyle on BuildContext {
  bool get isDarkTheme {
    return true;
    // return Theme.of(this).brightness == Brightness.dark;
  }

  TextStyle get titleText =>
      AppText().titleText.copyWith(color: AppColor.primary, fontSize: 44.sp);
  TextStyle get headingText => AppText().headingText.copyWith(
    color: AppColor.primaryText,
    fontSize: 24.sp,
  );
  TextStyle get subHeadingText => AppText().subHeadingText.copyWith(
    color: AppColor.baseText,
    fontSize: 18.sp,
  );

  TextStyle get bodyText =>
      AppText().bodyText.copyWith(color: AppColor.baseText, fontSize: 16.sp);
  TextStyle get lightText =>
      AppText().lightText.copyWith(color: AppColor.baseText);
}
