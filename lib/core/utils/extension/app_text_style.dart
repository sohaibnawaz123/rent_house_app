import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/resource/app_text.dart';

extension AppTextStyle on BuildContext {
  bool get isDarkTheme {
    return true;
    // return Theme.of(this).brightness == Brightness.dark;
  }

  TextStyle get titleText =>
      AppText().titleText.copyWith(color: AppColor.primaryText);
  TextStyle get headingText =>
      AppText().headingText.copyWith(color: AppColor.headingText);
  TextStyle get subHeadingText =>
      AppText().subHeadingText.copyWith(color: AppColor.headingText);

  TextStyle get bodyText =>
      AppText().bodyText.copyWith(color: AppColor.baseText);
  TextStyle get bodyText2 =>
      AppText().bodyText.copyWith(color: AppColor.baseText);
  TextStyle get lightText =>
      AppText().lightText.copyWith(color: AppColor.baseText);
}
