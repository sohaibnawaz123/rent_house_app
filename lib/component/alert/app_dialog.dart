import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_color.dart';


appDialog(BuildContext context, Widget widget) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.transparent,
        shadowColor: AppColor.primaryText.withValues(alpha: 0.5),
        surfaceTintColor: AppColor.primaryText.withValues(alpha: 0.5),
        iconPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        content: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.white,
          ),
          child: widget,
        ),
      );
    },
  );
}
