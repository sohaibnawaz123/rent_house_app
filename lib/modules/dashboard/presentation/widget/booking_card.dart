import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';

enum BookingStatus { upcoming, completed, cancelled }

class BookingCard extends StatelessWidget {
  final BookingStatus bookingStatus;
  const BookingCard({super.key, this.bookingStatus= BookingStatus.upcoming});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       Row(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AppImage.asset(assetPath: AppAsset.propertyTwo, size: 80),
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
                          data: 'Batavia Apartments',
                          textStyle: context.bodyText.copyWith(
                            color: AppColor.primaryText,
                            fontWeight: AppFontWeight.semiBold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                    ],
                  ),
                  IconList(
                    data: 'Jl. Tentara Pelajar No.47, RW.001',
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
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
