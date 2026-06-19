import 'package:flutter/material.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

import '../../../../component/image/app_network_image.dart';

class IconsCards extends StatelessWidget {
  final String? prifixIcon;
  final String? suffixIcon;
  final String? title;
  final String value;
  final void Function()? onTap;
  const IconsCards({
    super.key,
    this.prifixIcon,
    this.suffixIcon,
    this.title,
    required this.value, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.highlight.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          spacing: 20,
          children: [
            if (prifixIcon != null) ...[
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColor.base,
      
                child: AppImage.svg(svgPath: prifixIcon ?? "", size: 28),
              ),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  if (title != null)
                    Content(
                      data: title ?? 'Date',
                      textStyle: context.headingText.copyWith(
                        color: AppColor.baseText,
                      ),
                      size: 14,
                    ),
                  Content(
                    data: value,
                    textStyle: context.headingText.copyWith(
                      color: AppColor.primaryText,
                    ),
                    size: 16,
                  ),
                ],
              ),
            ),
            if (suffixIcon != null) ...[
              AppImage.svg(
                svgPath: suffixIcon ?? '',
                svgColor: AppColor.baseText,
                size: 24,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
