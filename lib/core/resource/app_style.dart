import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_color.dart';

class AppStyle {
  AppStyle._();
  static final AppStyle _instance = AppStyle._();
  factory AppStyle() => _instance;

  static final InputBorder inputBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: AppColor.highlightText, width: 1),
  );
  static final InputBorder errorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColor.black),
  );
  static final BoxBorder border = Border.all(
    color: AppColor.black.withValues(alpha: 0.15),
    width: 1,
  );
  static final BoxDecoration tileStyle = BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(8),
    border: border,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  );

  static final BoxDecoration tileStyleAlt = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: AppColor.black, width: 2.5),
  );
}
