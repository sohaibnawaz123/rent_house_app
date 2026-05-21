import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/component/text_field/content_field.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardhome/dashboardhome_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/recommended_property_card.dart';

class DashboardhomeView extends StatefulWidget {
  final DashboardhomeBloc bloc;
  const DashboardhomeView({super.key, required this.bloc});

  @override
  State<DashboardhomeView> createState() => _DashboardhomeViewState();
}

class _DashboardhomeViewState extends State<DashboardhomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          context.pagePadding.top - 20,
          context.pagePadding.left,
          context.pagePadding.bottom,
        ),
        child: ListView(
          children: [
            HomeHeader(address: widget.bloc.initialParams.address),
            20.heightBox,
            SearchFeild(),
            20.heightBox,
            OfferCard(),
            20.heightBox,
            RecommendedLocations(),
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  final String? address;
  const HomeHeader({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconList(
                isLeft: false,
                data: 'Location',
                style: context.lableText.copyWith(
                  fontWeight: AppFontWeight.medium,
                ),
                size: 14,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColor.btnBg,
                ),
              ),
              IconList(
                isCenter: false,
                // isLeft: false,
                // ignore: dead_null_aware_expression
                data: address ?? 'Yogyakarta, Ind',
                style: context.lableText.copyWith(
                  fontWeight: AppFontWeight.semiBold,
                  color: AppColor.black,
                ),
                size: 14,
                icon: AppImage.svg(
                  svgPath: AppAsset.marker,
                  svgColor: AppColor.btnBg,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: AppColor.baseText.withValues(alpha: 0.5),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AppImage.svg(svgPath: AppAsset.notification, size: 28),
              Positioned(
                top: 5,
                right: 5,
                child: Icon(Icons.circle, color: Colors.redAccent, size: 10),
              ),
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.all(8),
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: AppColor.baseText.withValues(alpha: 0.5),
            ),
          ),
          child: AppImage.svg(svgPath: AppAsset.chat, size: 28),
        ),
      ],
    );
  }
}

class SearchFeild extends StatelessWidget {
  const SearchFeild({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentField(
      prefixIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppImage.svg(
          svgPath: AppAsset.search,
          size: 24,
          svgColor: AppColor.btnBg,
        ),
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.all(10),
        child: AppImage.svg(svgPath: AppAsset.filter, size: 24),
      ),
      hintText: 'Search Property',
      hintStyle: context.bodyText,
      contentPadding: EdgeInsetsGeometry.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColor.baseText),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColor.baseText),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColor.primary),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(context.pagePadding.left, 0, 0, 0),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Content(
                  data: 'GET YOUR 20% CASHBACK',
                  textStyle: context.headingText.copyWith(
                    color: AppColor.white,
                  ),
                ),
                Content(
                  data: '*Expired 25 Aug 2026',
                  textStyle: context.bodyText.copyWith(color: AppColor.white),
                  size: 12,
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                alignment: AlignmentGeometry.centerRight,
                children: [
                  Positioned(
                    top: -50,
                    right: -100,
                    left: 40,
                    bottom: 0,

                    child: Container(
                      width: 150,
                      height: 150,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        // shape: BoxShape.circle,
                        color: AppColor.warning,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: AppImage.asset(
                      assetPath: AppAsset.building,
                      size: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendedLocations extends StatefulWidget {
  const RecommendedLocations({super.key});

  @override
  State<RecommendedLocations> createState() => _RecommendedLocationsState();
}

class _RecommendedLocationsState extends State<RecommendedLocations> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Heading
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Content(
              data: 'Recommended',
              textStyle: context.headingText.copyWith(
                color: AppColor.primaryText,
              ),
              size: 18,
            ),
            Content(
              data: 'See All',
              textStyle: context.bodyText.copyWith(color: AppColor.primary),
              size: 14,
            ),
          ],
        ),
        20.heightBox,
        SizedBox(
          height: 165,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return RecommendedPropertyCard();
            },
            separatorBuilder: (context, index) {
              return 10.widthBox;
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
