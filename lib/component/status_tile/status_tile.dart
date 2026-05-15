// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
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
    this.backgroundColor = AppColor.white,
    this.textColor,
    this.type = StatusTileType.error,
  });

  @override
  Widget build(BuildContext context) {
    IconData iconAsset;
    Color iconBgColor;
    switch (type) {
      case StatusTileType.success:
        iconAsset = Icons
            .check_circle_outline_outlined; // You should have a check icon asset
        iconBgColor = AppColor.success; // Define in your AppColor
        break;
      case StatusTileType.info:
        iconAsset = Icons.info_outline_rounded;
        iconBgColor = AppColor.primary; // Define in your AppColor
        break;
      case StatusTileType.error:
        iconAsset = Icons.error_outline_sharp;
        iconBgColor = AppColor.errorText; // Define in your AppColor
        break;
      }
    return Container(
      // margin: !isButton ? EdgeInsets.zero : context.buttonMarginTopBottom,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: backgroundColor!.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        // spacing: 10.w, // Row does not have spacing, use SizedBox
        mainAxisAlignment: isCenter
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Icon(iconAsset, color: iconBgColor, size: 22.w),
          SizedBox(width: 10.w),
          Flexible(
            child: Content(
              data: error,
              size: 14,
              textStyle: context.bodyText,
              color:
                  backgroundColor ??
                  (!isButton ? AppColor.errorText : AppColor.primary),
              alignment: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
