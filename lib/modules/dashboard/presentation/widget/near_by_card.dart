import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_entity.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';

class NearByCard extends StatelessWidget {
  final PropertyEntity? data;
  const NearByCard({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        spacing: 10,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: data!.image.isNotEmpty
                ? AppImage.network(size: 80, imageUrl: data!.image)
                : AppImage.asset(assetPath: AppAsset.propertyTwo, size: 80),
          ),
          Expanded(
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Content(
                  data: data?.name ??"",
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
                  data: data?.address?.addressline ?? 'Imogiri, Yogyakarta',
                  color: AppColor.baseText,
                  icon: AppImage.svg(
                    svgPath: AppAsset.locationIcon,
                    size: 16,
                    svgColor: AppColor.baseText,
                  ),
                ),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Content(
                      data: '\$${data?.price}/${data?.pricePeriod}',
                      textStyle: context.bodyText.copyWith(
                        color: AppColor.primaryText,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      size: 14,
                    ),
                    _rating(context, 4.5),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rating(BuildContext ctx, double value) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.warning.withValues(alpha: 0.15),
      ),

      child: Row(
        spacing: 2,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.star, color: AppColor.warning, size: 14),
          Content(
            weight: AppFontWeight.semiBold,
            data: value.toString(),
            color: AppColor.primaryText,
            size: 12,
            textStyle: ctx.bodyText,
          ),
        ],
      ),
    );
  }
}
