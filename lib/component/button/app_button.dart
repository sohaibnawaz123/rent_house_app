// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

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
    this.height = 60,
    this.radius = 6,
    this.padding,
    this.onTap,
    this.borderWidth,
    this.borderColor,
    this.isLeft = true,
    this.gradient,
  });
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isLoading || isDisable) ? () {} : onTap,
      child: Container(
        height: isResponsiveHeight ? null : height.h,
        width: isResponsiveWidth ? null : width,
        decoration: BoxDecoration(
          color: isDisable
              ? AppColor.primary.withValues(alpha: 0.3)
              : isLoading
              ? buttonColor ?? AppColor.primary.withValues(alpha: 0.7)
              : buttonColor ?? AppColor.primary,
          gradient: gradient,
          borderRadius: BorderRadius.circular(radius.r),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1,
          ),
        ),
        child: Center(
          child: Padding(
            padding:
                padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 5.h),
            child: isLoading
                ? Center(
                    child: 
                    // LoadingAnimationWidget.discreteCircle(
                    //   color: buttonColor == null
                    //       ? AppColor.blueLight
                    //       : AppColor.highlight,
                    //   secondRingColor: buttonColor == null
                    //       ? AppColor.base
                    //       : AppColor.dividerHighlight,
                    //   thirdRingColor: buttonColor == null
                    //       ? AppColor.primarylight
                    //       : AppColor.black.withValues(alpha: 0.5),
                    //   size: isResponsiveHeight ? fontSize : 30,
                    // ),
                    CircularProgressIndicator(color: fontColor)
                  )
                : iconPath != null
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: isLeft
                        ?
                          // Icon(icon, color: iconColor, size: iconSize),
                          [
                            SvgPicture.asset(
                              iconPath!,
                              fit: BoxFit.contain,
                              theme: SvgTheme(
                                currentColor: fontColor,
                                xHeight: 10.h,
                              ),
                              colorFilter: ColorFilter.mode(
                                fontColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 8),
                            Content(
                              data: title,
                              size: fontSize,

                              textStyle: context.subHeadingText.copyWith(
                                fontWeight: fontWeight,
                                color: fontColor,
                                fontSize: fontSize,
                              ),

                              alignment: TextAlign.center,
                            ),
                          ]
                        : [
                            Content(
                              data: title,
                              size: fontSize,

                              textStyle: context.subHeadingText.copyWith(
                                fontWeight: fontWeight,
                                color: fontColor,
                                fontSize: fontSize,
                              ),
                              alignment: TextAlign.center,
                            ),
                            SizedBox(width: 8),

                            SvgPicture.asset(
                              iconPath!,
                              fit: BoxFit.contain,
                              color: fontColor,
                              theme: SvgTheme(
                                currentColor: fontColor,
                                xHeight: 10.h,
                              ),
                            ),
                          ],
                  )
                : Content(
                    data: title,
                    size: fontSize,
                    textStyle: context.subHeadingText.copyWith(
                      fontWeight: fontWeight,
                      color: fontColor,
                      fontSize: fontSize,
                    ),
                    alignment: TextAlign.center,
                  ),
          ),
        ),
      ),
    );
  }
}
