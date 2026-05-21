import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';

class RecommendedPropertyCard extends StatefulWidget {
  const RecommendedPropertyCard({super.key});

  @override
  State<RecommendedPropertyCard> createState() =>
      _RecommendedPropertyCardState();
}

class _RecommendedPropertyCardState extends State<RecommendedPropertyCard> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 225,
        // height: 165,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AppImage.asset(
              assetPath: AppAsset.propertyOne,
              size: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColor.primaryText.withValues(alpha: 0.7),
                    AppColor.primaryText.withValues(alpha: 0.35),
                    AppColor.primaryText.withValues(alpha: 0),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(alignment: Alignment.topRight, child: _priceCard()),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Content(
                              data: 'Ayana Homestay',
                              textStyle: context.bodyText.copyWith(
                                color: AppColor.white,
                                fontWeight: AppFontWeight.semiBold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              size: 14,
                            ),
                            IconList(
                              data: 'Imogiri, Yogyakarta',
                              color: AppColor.white,
                              icon: AppImage.svg(
                                svgPath: AppAsset.locationIcon,
                                size: 16,
                                svgColor: AppColor.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavourite = !isFavourite;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColor.white,
                          radius: 18,
                          child:isFavourite?
                          AppImage.svg(
                                  svgPath: AppAsset.fillHeart,
                                  size: 20,
                                  
                                )
                           :AppImage.svg(
                            svgPath: AppAsset.favourite,
                            size: 20,
                            svgColor: AppColor.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceCard() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: RichText(
        text: TextSpan(
          text: '\$ 30',
          style: context.bodyText.copyWith(
            color: AppColor.primary,
            fontWeight: AppFontWeight.semiBold,
          ),
          children: [
            TextSpan(
              text: '/ Monthly',
              style: TextStyle(fontSize: 12, color: AppColor.baseText),
            ),
          ],
        ),
      ),
    );
  }
}
