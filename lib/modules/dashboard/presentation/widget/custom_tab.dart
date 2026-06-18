import 'package:flutter/material.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

class CustomBookingTab extends StatefulWidget {
  final String data;
  final void Function()? onTap;
  final bool isSelected;
  const CustomBookingTab({
    super.key,
    required this.data,
    this.onTap,
    required this.isSelected,
  });

  @override
  State<CustomBookingTab> createState() => _CustomBookingTabState();
}

class _CustomBookingTabState extends State<CustomBookingTab> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        // width: double.minPositive,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.isSelected ? AppColor.primary : AppColor.transparent,
        ),
        child: Content(
          data: widget.data.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textStyle: context.bodyText.copyWith(
            color: widget.isSelected ? AppColor.white : AppColor.baseText,
            fontWeight: widget.isSelected
                ? AppFontWeight.semiBold
                : AppFontWeight.medium,
          ),
          size: 14,
        ),
      ),
    );
  }
}
