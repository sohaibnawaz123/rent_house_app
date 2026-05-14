import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

class EmailorPhoneCard extends StatefulWidget {
  final bool isSelected;
  final void Function()? onTap;
  final String title;
  final String type;
  final String icon;
  const EmailorPhoneCard({
    super.key,
    this.onTap,
    required this.isSelected,
    required this.title,
    required this.type,
    required this.icon,
  });

  @override
  State<EmailorPhoneCard> createState() => _EmailorPhoneCardState();
}

class _EmailorPhoneCardState extends State<EmailorPhoneCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? AppColor.highlight.withValues(alpha: 0.5)
              : AppColor.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: widget.isSelected ? AppColor.primary : AppColor.baseText,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColor.white,
                shape: BoxShape.circle,
              ),
              child: AppImage.svg(
                svgPath: widget.icon,
                svgColor: AppColor.primaryText,
              ),
            ),
            20.widthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Content(
                    data: "Via ${widget.type}",
                    textStyle: context.bodyText.copyWith(
                      fontWeight: AppFontWeight.medium,
                      color: AppColor.primaryText.withValues(alpha: 0.7),
                    ),
                    size: 14,
                  ),
                  Content(
                    data: widget.title,
                    textStyle: context.bodyText.copyWith(
                      color: AppColor.primaryText,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
