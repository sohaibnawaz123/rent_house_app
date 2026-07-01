import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_entity.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';

class PopularPlaceCard extends StatefulWidget {
  final PropertyEntity? propertyData;
  const PopularPlaceCard({super.key, this.propertyData});

  @override
  State<PopularPlaceCard> createState() => _PopularPlaceCardState();
}

class _PopularPlaceCardState extends State<PopularPlaceCard> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    final property = widget.propertyData;
    final imageUrl = property?.image ?? '';
    final propertyName = property?.name ?? 'Takatea Homestay';
    final address =
        property?.address?.addressline ?? 'Jl. Tentara Pelajar No.47, RW.001';
    final priceText = property == null
        ? '\$0/month'
        : '\$${property.price}/${property.pricePeriod}';

    return SizedBox(
      width: double.infinity,
      child: Row(
        spacing: 10,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageUrl.isNotEmpty
                ? AppImage.network(
                    imageUrl: imageUrl,
                    size: 80,
                  )
                : AppImage.asset(assetPath: AppAsset.propertyTwo, size: 80),
          ),
          Expanded(
            child: Column(
              spacing: 5,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Content(
                        data: propertyName,
                        textStyle: context.bodyText.copyWith(
                          color: AppColor.primaryText,
                          fontWeight: AppFontWeight.semiBold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavourite = !isFavourite;
                        });
                      },
                      child: isFavourite
                          ? AppImage.svg(svgPath: AppAsset.fillHeart, size: 24)
                          : AppImage.svg(
                              svgPath: AppAsset.favourite,
                              size: 24,
                              svgColor: AppColor.error,
                            ),
                    ),
                  ],
                ),
                IconList(
                  data: address,
                  icon: AppImage.svg(
                    svgPath: AppAsset.locationIcon,
                    svgColor: AppColor.baseText,
                    size: 16,
                  ),
                  color: AppColor.baseText,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Content(
                      data: priceText,
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
