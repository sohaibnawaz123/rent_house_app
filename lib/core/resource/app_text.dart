import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';


class AppText {
  AppText._internal()
    : _baseTextStyle = GoogleFonts.inter(
        fontWeight: AppFontWeight.regular,
        // letterSpacing: -0.8,
        height: 1.2,
      ),
      _secondaryTextStyle = GoogleFonts.inter(
        fontWeight: AppFontWeight.regular,
        letterSpacing: -0.5,
        height: 1.1,
      );

  static final AppText _instance = AppText._internal();

  factory AppText() {
    return _instance;
  }

  final TextStyle _baseTextStyle;
  final TextStyle _secondaryTextStyle;

  TextStyle get titleText => _secondaryTextStyle.copyWith(
    fontSize: 44,
    fontWeight: AppFontWeight.medium,
  );
  TextStyle get headingText =>
      _baseTextStyle.copyWith(fontSize: 24, fontWeight: AppFontWeight.bold);
  TextStyle get subHeadingText =>
      _baseTextStyle.copyWith(fontSize: 20, fontWeight: AppFontWeight.semiBold);

  TextStyle get bodyText =>
      _baseTextStyle.copyWith(fontSize: 16, fontWeight: AppFontWeight.medium);

  TextStyle get lightText =>
      _baseTextStyle.copyWith(fontSize: 14, fontWeight: AppFontWeight.light);
}
