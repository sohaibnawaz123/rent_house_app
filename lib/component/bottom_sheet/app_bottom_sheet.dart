import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_padding.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';


Future<T?> appBottomSheet<T>(
  BuildContext context,
  Widget widget, {
  String? title,
  String? subTitle,
  bool isDismissible = true,
  bool isMaxHeight = true,
  double maxHeight = 0.6,
}) {
  return showModalBottomSheet<T>(
    useSafeArea: true,
    isDismissible: isDismissible,
    context: context,
    isScrollControlled: true,

    backgroundColor: AppColor.base,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        left: context.sheetPadding.left,
        right: context.sheetPadding.right,
        top: context.sheetPadding.top,
      ),
      child: ConstrainedBox(
        constraints: isMaxHeight
            ? BoxConstraints()
            : BoxConstraints(maxHeight: maxHeight.sh),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40.w,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColor.highlight,
                  borderRadius: BorderRadius.circular(4),
                ),
              ).paddingOnly(bottom: 25.h),
              if (title != null)
                Content(
                  data: title.toUpperCase(),
                  size: 28,
                  alignment: TextAlign.center,
                  textStyle: context.titleText,
                ).paddingOnly(bottom: 18.h),
              if (subTitle != null)
                Content(
                  data: subTitle,
                  size: 16,
                  textStyle: context.bodyText,
                  color: AppColor.highlightdark,
                  alignment: TextAlign.center,
                ).paddingOnly(bottom: 20.h),
              widget,
            ],
          ).paddingOnly(bottom: context.sheetPadding.bottom),
        ),
      ),
    ).paddingOnly(bottom: MediaQuery.of(context).viewInsets.bottom),
  );
}
