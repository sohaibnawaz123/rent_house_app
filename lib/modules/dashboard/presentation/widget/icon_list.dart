import 'package:flutter/material.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

class IconList extends StatelessWidget {
  final String data;
  final double? size;
  final bool isCenter;
  final Color? color;

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
    this.isCenter = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: isCenter
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          if (isLeft) icon ?? SizedBox.shrink(),
          Flexible(
            fit: FlexFit.loose,
            child: Content(
              data: data,
              textStyle:
                  style ??
                  context.bodyText.copyWith(color: color ?? AppColor.primary),
              size: size ?? 12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!isLeft) icon ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
