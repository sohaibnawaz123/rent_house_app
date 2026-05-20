import 'package:flutter/material.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

class IconList extends StatelessWidget {
  final String data;
  final double? size;

  final TextStyle? style;
  final Widget? icon;
  final bool isLeft;
  final void Function()? onTap;

  const IconList({
    super.key,
    required this.data,
    this.style,
    this.icon,
    this.isLeft = true,
    this.onTap,
    this.size = 12,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (isLeft) icon ?? SizedBox.shrink(),
          Content(
            data: data,
            textStyle:
                style ?? context.bodyText.copyWith(color: AppColor.primary),
            size: size ?? 12,
          ),
          if (!isLeft) icon ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
