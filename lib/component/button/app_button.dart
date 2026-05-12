// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

enum _AppButtonType { auto, text, icon, iconWithText }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.isResponsiveHeight = false,
    this.isResponsiveWidth = false,

    this.isLoading = false,
    this.isDisable = false,
    this.title = '',
    this.iconPath,
    this.iconSize = 24,
    this.buttonColor,
    this.border,
    this.fontColor = AppColor.white,
    this.fontSize = 16,
    this.width = double.infinity,
    this.fontWeight,
    this.height = 50,
    this.radius = 8,
    this.padding,
    this.onTap,
    this.borderWidth,
    this.borderColor,
    this.isLeft = true,
    this.gradient,
  }) : _type = _AppButtonType.auto;

  factory AppButton.textButton({
    Key? key,
    bool isResponsiveHeight = false,
    bool isResponsiveWidth = false,
    bool isLoading = false,
    bool isDisable = false,
    required String title,
    Color? buttonColor,
    BorderSide? border,
    Color fontColor = AppColor.white,
    double fontSize = 16,
    double? width = double.infinity,
    FontWeight? fontWeight,
    double height = 60,
    double radius = 6,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
    double? borderWidth,
    Color? borderColor,
    Gradient? gradient,
  }) {
    return AppButton._(
      key: key,
      isResponsiveHeight: isResponsiveHeight,
      isResponsiveWidth: isResponsiveWidth,
      isLoading: isLoading,
      isDisable: isDisable,
      title: title,
      buttonColor: buttonColor,
      border: border,
      fontColor: fontColor,
      fontSize: fontSize,
      width: width,
      fontWeight: fontWeight,
      height: height,
      radius: radius,
      padding: padding,
      onTap: onTap,
      borderWidth: borderWidth,
      borderColor: borderColor,
      gradient: gradient,
      type: _AppButtonType.text,
    );
  }

  factory AppButton.iconButton({
    Key? key,
    bool isResponsiveHeight = false,
    bool isResponsiveWidth = false,
    bool isLoading = false,
    bool isDisable = false,
    required String iconPath,
    double? iconSize = 24,
    Color? buttonColor,
    BorderSide? border,
    Color fontColor = AppColor.white,
    double fontSize = 16,
    double? width = double.infinity,
    FontWeight? fontWeight,
    double height = 60,
    double radius = 6,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
    double? borderWidth,
    Color? borderColor,
    Gradient? gradient,
  }) {
    return AppButton._(
      key: key,
      isResponsiveHeight: isResponsiveHeight,
      isResponsiveWidth: isResponsiveWidth,
      isLoading: isLoading,
      isDisable: isDisable,
      iconPath: iconPath,
      iconSize: iconSize,
      buttonColor: buttonColor,
      border: border,
      fontColor: fontColor,
      fontSize: fontSize,
      width: width,
      fontWeight: fontWeight,
      height: height,
      radius: radius,
      padding: padding,
      onTap: onTap,
      borderWidth: borderWidth,
      borderColor: borderColor,
      gradient: gradient,
      type: _AppButtonType.icon,
    );
  }

  factory AppButton.iconWithText({
    Key? key,
    bool isResponsiveHeight = false,
    bool isResponsiveWidth = false,
    bool isLoading = false,
    bool isDisable = false,
    required String title,
    required String iconPath,
    double? iconSize = 24,
    Color? buttonColor,
    BorderSide? border,
    Color fontColor = AppColor.white,
    double fontSize = 16,
    double? width = double.infinity,
    FontWeight? fontWeight,
    double height = 60,
    double radius = 6,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
    double? borderWidth,
    Color? borderColor,
    bool isLeft = true,
    Gradient? gradient,
  }) {
    return AppButton._(
      key: key,
      isResponsiveHeight: isResponsiveHeight,
      isResponsiveWidth: isResponsiveWidth,
      isLoading: isLoading,
      isDisable: isDisable,
      title: title,
      iconPath: iconPath,
      iconSize: iconSize,
      buttonColor: buttonColor,
      border: border,
      fontColor: fontColor,
      fontSize: fontSize,
      width: width,
      fontWeight: fontWeight,
      height: height,
      radius: radius,
      padding: padding,
      onTap: onTap,
      borderWidth: borderWidth,
      borderColor: borderColor,
      isLeft: isLeft,
      gradient: gradient,
      type: _AppButtonType.iconWithText,
    );
  }

  const AppButton._({
    super.key,
    this.isResponsiveHeight = false,
    this.isResponsiveWidth = false,
    this.isLoading = false,
    this.isDisable = false,
    this.title = '',
    this.iconPath,
    this.iconSize = 24,
    this.buttonColor,
    this.border,
    this.fontColor = AppColor.white,
    this.fontSize = 16,
    this.width = double.infinity,
    this.fontWeight,
    this.height = 60,
    this.radius = 6,
    this.padding,
    this.onTap,
    this.borderWidth,
    this.borderColor,
    this.isLeft = true,
    this.gradient,
    required _AppButtonType type,
  }) : _type = type;

  final bool isLoading, isDisable;
  final String title;
  final String? iconPath;
  final bool isResponsiveHeight, isResponsiveWidth;
  final double? iconSize;
  final Color? buttonColor;
  final BorderSide? border;
  final Color fontColor;
  final double fontSize;
  final FontWeight? fontWeight;
  final double? width;
  final double height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double? borderWidth;
  final Color? borderColor;
  final bool isLeft;
  final Gradient? gradient;
  final _AppButtonType _type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isLoading || isDisable) ? () {} : onTap,
      child: Container(
        height: isResponsiveHeight ? null : height.h,
        width: isResponsiveWidth ? null : width,
        decoration: BoxDecoration(
          color: isDisable
              ? AppColor.btnBg.withValues(alpha: 0.3)
              : isLoading
              ? buttonColor ?? AppColor.btnBg.withValues(alpha: 0.7)
              : buttonColor ?? AppColor.btnBg,
          gradient: gradient,
          borderRadius: BorderRadius.circular(radius.r),
          border: border != null
              ? Border.fromBorderSide(border!)
              : Border.all(
                  color: borderColor ?? Colors.transparent,
                  width: borderWidth ?? 1,
                ),
        ),
        child: Center(
          child: Padding(
            padding:
                padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 5.h),
            child: _buildChild(context),
          ),
        ),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: fontColor));
    }

    final type = _resolvedType;
    if (type == _AppButtonType.icon) {
      return _buildIcon();
    }

    if (type == _AppButtonType.iconWithText) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: isLeft
            ? [_buildIcon(), SizedBox(width: 8.w), _buildText(context)]
            : [_buildText(context), SizedBox(width: 8.w), _buildIcon()],
      );
    }

    return _buildText(context);
  }

  _AppButtonType get _resolvedType {
    if (_type != _AppButtonType.auto) return _type;
    return iconPath == null ? _AppButtonType.text : _AppButtonType.iconWithText;
  }

  Widget _buildIcon() {
    return SvgPicture.asset(
      iconPath!,
      height: iconSize?.h,
      width: iconSize?.w,
      fit: BoxFit.contain,
      theme: SvgTheme(currentColor: fontColor, xHeight: 10.h),
      colorFilter: ColorFilter.mode(fontColor, BlendMode.srcIn),
    );
  }

  Widget _buildText(BuildContext context) {
    return Content(
      data: title,
      size: fontSize,
      textStyle: context.subHeadingText.copyWith(
        fontWeight: fontWeight,
        color: fontColor,
        fontSize: fontSize,
      ),
      alignment: TextAlign.center,
    );
  }
}
