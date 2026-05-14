
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

enum StatusTileType { success, error, info }

class StatusTile extends StatelessWidget {
  final String error;
  final bool isCenter;
  final bool isButton;
  final Color? backgroundColor;
  final Color? textColor;
  final StatusTileType type;
  const StatusTile({
    super.key,
    required this.error,
    this.isCenter = false,
    this.isButton = false,
    this.backgroundColor,
    this.textColor,
    this.type = StatusTileType.error,
  });

  @override
  Widget build(BuildContext context) {
    IconData iconAsset;
    Color iconBgColor;
    switch (type) {
      case StatusTileType.success:
        iconAsset = Icons.check_circle_outline_outlined; // You should have a check icon asset
        iconBgColor = AppColor.success; // Define in your AppColor
        break;
      case StatusTileType.info:
        iconAsset = Icons.info_outline_rounded;
        iconBgColor = AppColor.highlight; // Define in your AppColor
        break;
      case StatusTileType.error:
         iconAsset = Icons.error_outline_sharp;
        iconBgColor = AppColor.errorText; // Define in your AppColor
        break;
      default:
        iconAsset = Icons.info_outline_rounded;
        iconBgColor = AppColor.errorText;
        break;
    }
    return Container(
      // margin: !isButton ? EdgeInsets.zero : context.buttonMarginTopBottom,
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: backgroundColor ?? (!isButton
            ? AppColor.transparent
            : AppColor.errorText.withValues(alpha: 0.9)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        // spacing: 10.w, // Row does not have spacing, use SizedBox
        mainAxisAlignment: isCenter
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconBgColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(6.w),
            child: Icon(
              iconAsset,
              color: iconBgColor,
              size: 22.w,
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: Content(
              data: error,
              size: 14,
              textStyle: context.bodyText,
              color: textColor ?? (!isButton ? AppColor.errorText : AppColor.primary),
              alignment: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
