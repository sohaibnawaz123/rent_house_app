import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    this.title,
    this.category,
    this.showBackButton = true,
    this.showactions = false,
    this.haveBg = false,
    this.titleColor,
    this.iconColor,
    this.actions,
    this.onTap,
  });

  final String? title;
  final String? category;
  final Color? titleColor;
  final Color? iconColor;
  final bool showBackButton;
  final bool showactions;
  final bool haveBg;
  final Widget? actions;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewInsets.top + 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 48,
              child: showBackButton
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          if (onTap != null) {
                            onTap!();
                          } else {
                            context.popPage();
                          }
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: iconColor ?? AppColor.black,
                          size: 18,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Content(
                      data: title ?? '',
                      size: 20.sp,
                      textStyle: context.headingText.copyWith(
                        fontWeight: AppFontWeight.semiBold,
                        color: titleColor ?? AppColor.primaryText,
                      ),
                    ),
                    if (category != null)
                      Content(
                        data: category ?? '',
                        size: 16.sp,
                        textStyle: context.bodyText.copyWith(
                          fontWeight: AppFontWeight.regular,
                          color: AppColor.secondaryText,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (showactions)
              Align(
                alignment: Alignment.centerRight,
                child: actions ?? const SizedBox.shrink(),
              )
            else
              const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}
