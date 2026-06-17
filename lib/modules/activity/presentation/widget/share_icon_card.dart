import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
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
        color: AppColor.primary.withValues(alpha: 0.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: AppColor.btnBg.withValues(alpha: 0.15),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 15,
        children: [
          AppImage.svg(svgPath: entity.iconName, size: 24),
          Content(
            data: entity.name,
            textStyle: context.bodyText.copyWith(color: AppColor.black),
            size: 14,
          ),
        ],
      ),
    );
  }
}
