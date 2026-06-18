import 'package:flutter/material.dart';

class AppColor {
  AppColor._internal();
  static final AppColor _instance = AppColor._internal();

  factory AppColor() {
    return _instance;
  }

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color base = Color(0xFFFCFCFD);

  static const Color primary = Color(0xFF6941C6);
  static const Color btnBg = Color(0xFF7F56D9);

  static const Color grey = Color(0xFFF5F5F5);
  static const Color warning = Color(0xFFFDB022);
  static const Color highlight = Color(0xFFE9D7FE);
  static const Color lighthighlight = Color(0xFFF9F5FF);
  static Color? get highlightdark => null;

  // >>>>>>>>>>>>>>>>>>>>>>> Text <<<<<<<<<<<<<<<<<<<<<<<

  static const Color primaryText = Color(0xFF1F2A37);
  static const Color secondaryText = Color(0xFFB0BEC5);
  static const Color headingText = Color(0xFF90A4AE);
  static const Color highlightText = Color(0xFFB0BEC5);
  static const Color baseText = Color(0xFF9DA4AE);

  static const Color disabledText = Color(0xFFF9FAFB);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color disabledbtn = Color(0xFFD6BBFB);
  static const Color errorText = Color(0xFFF97066);
  static const Color error = Color(0xFFF04438);
  static const Color success = Color(0xFF32D583);
  static const Color greenShade = Color(0xFFD1FADF);

  static const Gradient iconBgGradient = LinearGradient(
    colors: [Color(0xff3BB3E4), Color(0xff268DE3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
