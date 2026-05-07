import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_padding.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:flutter_svg/svg.dart';

class AppAppbar extends StatelessWidget {
  final String title;
  final double fontSize;
  final double? width;
  final Widget? trailing;
  final bool isWhite, isLeading;
  final void Function()? onLeadingTap;

  const AppAppbar({
    super.key,
    this.fontSize = 28,
    required this.title,
    this.trailing,
    this.width,
    this.isWhite = false,
    this.isLeading = true,
    this.onLeadingTap,
  });

  @override
  Widget build(BuildContext context) {
    final leading = SizedBox(
      width: width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: onLeadingTap ?? () => context.popPage(),
          child: SvgPicture.asset(
            AppAsset.back,
            width: 30.h,
            height: 30.h,
            colorFilter: isWhite
                ? ColorFilter.mode(AppColor.white, BlendMode.srcIn)
                : null,
          ),
        ),
      ),
    );

    final trailingWidget = SizedBox(
      width: width,
      child: trailing ?? SizedBox(width: 30.h, height: 30.h),
    );

    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: !isLeading
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          if (isLeading) leading,
          Content(
            data: title,
            size: fontSize,
            textStyle: context.titleText,
            color: isWhite ? AppColor.white : null,
          ),
          if (isLeading) trailingWidget,
        ],
      ),
    ).paddingSymmetric(horizontal: context.pagePadding.left);
  }
}
