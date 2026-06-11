import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';

class PropertyDetailEntity {
  final String title;
  final String value;
  final String? icon;

  PropertyDetailEntity({required this.title, required this.value, this.icon});
}

class PropertDetailCard extends StatelessWidget {
  final PropertyDetailEntity entity;
  const PropertDetailCard({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Content(
          data: entity.title,
          textStyle: context.bodyText.copyWith(
            fontWeight: AppFontWeight.medium,
          ),
          size: 16,
        ),
        IconList(
          weight: AppFontWeight.bold,
          size: 14,
          color: AppColor.black,
          data: entity.value,
          icon: entity.icon!.isNotEmpty
              ? AppImage(
                  imageUrl: entity.icon ?? AppAsset.logout,
                  size: 16,
                  svgColor: AppColor.black,
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
