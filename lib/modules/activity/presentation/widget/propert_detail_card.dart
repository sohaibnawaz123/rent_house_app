import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';

class PropertDetailCard extends StatelessWidget {
  final String title;
  final String value;
  final String? iconPath;

  const PropertDetailCard({
    super.key,
    required this.title,
    required this.value,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    final hasIcon = iconPath != null && iconPath!.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Content(
          data: title,
          textStyle: context.bodyText.copyWith(
            fontWeight: AppFontWeight.medium,
          ),
          size: 16,
        ),
        IconList(
          weight: AppFontWeight.bold,
          size: 14,
          color: AppColor.black,
          data: value,
          icon: hasIcon
              ? AppImage(
                  imageUrl: iconPath!,
                  size: 16,
                  svgColor: AppColor.black,
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
