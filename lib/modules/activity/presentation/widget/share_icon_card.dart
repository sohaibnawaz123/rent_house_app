import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

class ShareIconCardEntity {
  final String name;
  final String iconName;

  ShareIconCardEntity({required this.name, required this.iconName});
}

class ShareIconCard extends StatelessWidget {
  final ShareIconCardEntity entity;
  const ShareIconCard({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.highlight,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: AppColor.black.withValues(alpha: 0.15),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColor.white,
            child: AppImage.svg(svgPath: entity.iconName, size: 28,svgColor: AppColor.btnBg,)),
          Content(
            data: entity.name,
            textStyle: context.bodyText.copyWith(color: AppColor.btnBg,fontWeight: AppFontWeight.semiBold),
            size: 14,
          ),
        ],
      ),
    );
  }
}
