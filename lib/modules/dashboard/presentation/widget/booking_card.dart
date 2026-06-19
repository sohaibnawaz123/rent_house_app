import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';

enum BookingStatus { upcoming, completed, cancelled }

enum BookedStatus { waitingpayment, checkin, completed, cancelled }

class BookingCard extends StatelessWidget {
  final BookingStatus bookingStatus;
  final BookedStatus? bookedStatus;
  final void Function()? onReviewTap;
  final void Function()? onCallTap;
  final bool showStatus;
  const BookingCard({
    super.key,
    this.bookingStatus = BookingStatus.upcoming,
    this.bookedStatus = BookedStatus.waitingpayment,
    this.onReviewTap,
    this.onCallTap,
    this.showStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // upcomming Card
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
                      Flexible(
                        fit: FlexFit.loose,
                        child: Content(
                          data: '12 Aug - 12 Sep',
                          textStyle: context.bodyText.copyWith(
                            color: AppColor.baseText,
                            fontWeight: AppFontWeight.semiBold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          size: 14,
                        ),
                      ),
                      if (showStatus) ...[
                        10.widthBox,
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: getColor().withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Content(
                              data: bookedStatus?.name ?? "Not Found",
                              textStyle: context.bodyText.copyWith(
                                color: getColor().withValues(alpha: 0.7),
                                fontWeight: AppFontWeight.semiBold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        if (bookingStatus.name == 'completed') ...[
          5.heightBox,
          Divider(
            thickness: 1,
            color: AppColor.baseText.withValues(alpha: 0.25),
          ),
          // 2.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: IconList(
              onTap: onReviewTap,
              data: 'Write review',
              icon: AppImage.svg(svgPath: AppAsset.reviews, size: 24),
              color: AppColor.baseText,
              size: 14,
            ),
          ),
          // 5.heightBox,
          Divider(
            thickness: 1,
            color: AppColor.baseText.withValues(alpha: 0.25),
          ),
          // 2.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: IconList(
              data: 'Call Agent',
              icon: AppImage.svg(svgPath: AppAsset.phone, size: 24),
              color: AppColor.baseText,
              size: 14,
            ),
          ),
        ],
        if (bookingStatus.name == 'cancelled') ...[
          5.heightBox,
          Divider(
            thickness: 1,
            color: AppColor.baseText.withValues(alpha: 0.25),
          ),
          // 2.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: IconList(
              onTap: onCallTap,
              data: 'Call Agent',
              icon: AppImage.svg(svgPath: AppAsset.phone, size: 24),
              color: AppColor.baseText,
              size: 14,
            ),
          ),
        ],
      ],
    );
  }

  Color getColor() {
    switch (bookedStatus) {
      case BookedStatus.waitingpayment:
      case BookedStatus.cancelled:
        return AppColor.error;

      case BookedStatus.checkin:
      case BookedStatus.completed:
        return AppColor.success;

      // case null:
      default:
        return AppColor.black;
    }
  }
}
