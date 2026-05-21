import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';

class NearByCard extends StatelessWidget {
  const NearByCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        spacing: 10,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AppImage.asset(assetPath: AppAsset.propertyTwo,size: 80,),
          ),
          Expanded(
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Content(
                  data: 'Ayana Homestay',
                  textStyle: context.bodyText.copyWith(
                    color: AppColor.primaryText,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  size: 16,
                ),
                IconList(
                  isLeft: true,
                  data: 'Imogiri, Yogyakarta',
                  color: AppColor.baseText,
                  icon: AppImage.svg(
                    svgPath: AppAsset.locationIcon,
                    size: 16,
                    svgColor: AppColor.baseText,
                  ),
                ),
                5.heightBox,
                Content(
                  data: '\$320/month',
                  textStyle: context.bodyText.copyWith(
                    color: AppColor.primaryText,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  size: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
