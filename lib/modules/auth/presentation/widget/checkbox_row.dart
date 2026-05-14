import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

class CheckRow extends StatefulWidget {
  final String title;
  final bool isChecked;
  final void Function()? onTap;
  const CheckRow({super.key, required this.isChecked, this.onTap, required this.title});

  @override
  State<CheckRow> createState() => _CheckRowState();
}

class _CheckRowState extends State<CheckRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 18.h,
            height: 18.h,
            decoration: BoxDecoration(
              color: widget.isChecked ? AppColor.btnBg : AppColor.white,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: widget.isChecked
                    ? AppColor.transparent
                    : AppColor.baseText,
                width: 1.5,
              ),
            ),
            child: Visibility(
              visible: widget.isChecked,
              child: Icon(Icons.check, size: 14.h, color: AppColor.white),
            ),
          ),
          10.widthBox,
          Content(
            data: widget.title,
            textStyle: context.lightText.copyWith(
              color: AppColor.primaryText,
              fontWeight: AppFontWeight.semiBold,
              height: 1.3
            ),
            size: 14,
          ),
        ],
      ),
    );
  }
}
