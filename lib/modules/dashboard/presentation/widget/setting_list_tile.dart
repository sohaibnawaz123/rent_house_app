import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';

class SettingListTile extends StatelessWidget {
  final String title;
  final String icon;
  final void Function()? onTap;
  const SettingListTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColor.highlight.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: IconList(
                style: context.bodyText.copyWith(
                  fontWeight: AppFontWeight.medium,
                  color: AppColor.black,
                ),
                size: 18,
                data: title,
                icon: AppImage.svg(svgPath: icon, size: 28,svgColor: AppColor.btnBg,),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: AppColor.primary,size: 20,),
          ],
        ),
      ),
    );
  }
}
