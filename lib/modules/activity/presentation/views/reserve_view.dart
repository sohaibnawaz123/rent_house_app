import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/activity/presentation/blocs/reserve/reserve_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/near_by_card.dart';

class ReserveView extends StatefulWidget {
  final ReserveBloc bloc;
  const ReserveView({super.key, required this.bloc});

  @override
  State<ReserveView> createState() => _ReserveViewState();
}

class _ReserveViewState extends State<ReserveView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.white,
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          context.pagePadding.top,
          context.pagePadding.right,
          context.pagePadding.bottom,
        ),
        children: [
          HeaderWidget(title: "Booking"),
          30.heightBox,
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 1, color: AppColor.baseText),
            ),
            child: NearByCard(),
          ),
          20.heightBox,
          BookingPeriod(),
          20.heightBox,
          BookingPayment(),
        ],
      ),
    );
  }
}

class BookingPeriod extends StatelessWidget {
  const BookingPeriod({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Content(
          data: 'Period',
          textStyle: context.headingText.copyWith(color: AppColor.primaryText),
          size: 18,
        ),
        15.heightBox,
        IconsCards(
          prifixIcon: AppAsset.calendar,
          suffixIcon: AppAsset.forward,
          value: '12 Aug - 12 Sep ',
          title: 'Date',
        ),
        10.heightBox,
        Content(
          data:
              'Make sure to check your date before making any sort of payments',
          textStyle: context.bodyText.copyWith(
            color: AppColor.baseText,
            height: 1.4,
          ),
          size: 14,
        ),
        10.heightBox,
        Divider(thickness: 1, color: AppColor.baseText, height: 10),
      ],
    );
  }
}

class BookingPayment extends StatelessWidget {
  const BookingPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Content(
          data: 'Payments',
          textStyle: context.headingText.copyWith(color: AppColor.primaryText),
          size: 18,
        ),
        15.heightBox,
        IconsCards(
          prifixIcon: AppAsset.wallet,
          suffixIcon: AppAsset.forward,
          value: 'Credit or Debit card',
          // title: 'Date',
        ),
        // 10.heightBox,
        10.heightBox,
        Divider(thickness: 1, color: AppColor.baseText, height: 10),
      ],
    );
  }
}

class IconsCards extends StatelessWidget {
  final String? prifixIcon;
  final String? suffixIcon;
  final String? title;
  final String value;
  const IconsCards({
    super.key,
    this.prifixIcon,
    this.suffixIcon,
    this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.highlight.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        spacing: 20,
        children: [
          if (prifixIcon != null) ...[
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColor.base,

              child: AppImage.svg(svgPath: prifixIcon ?? "", size: 28),
            ),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                if (title != null)
                  Content(
                    data: title ?? 'Date',
                    textStyle: context.headingText.copyWith(
                      color: AppColor.baseText,
                    ),
                    size: 14,
                  ),
                Content(
                  data: value,
                  textStyle: context.headingText.copyWith(
                    color: AppColor.primaryText,
                  ),
                  size: 16,
                ),
              ],
            ),
          ),
          if (suffixIcon != null) ...[
            AppImage.svg(
              svgPath: suffixIcon ?? '',
              svgColor: AppColor.baseText,
              size: 24,
            ),
          ],
        ],
      ),
    );
  }
}
