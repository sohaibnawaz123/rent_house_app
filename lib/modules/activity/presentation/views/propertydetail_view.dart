import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/activity/presentation/blocs/propertydetail/propertydetail_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';
import 'package:taxi_app/modules/onboarding/presentation/widget/pagination.dart';

class PropertydetailView extends StatefulWidget {
  final PropertydetailBloc bloc;
  const PropertydetailView({super.key, required this.bloc});

  @override
  State<PropertydetailView> createState() => _PropertydetailViewState();
}

class _PropertydetailViewState extends State<PropertydetailView> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> gallary = [
    AppAsset.propertyOne,
    AppAsset.propertyTwo,
    AppAsset.propertyOne,
    AppAsset.propertyTwo,
    AppAsset.propertyOne,
    AppAsset.propertyTwo,
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    // print(bottomInset);
    final bottomSpacing = bottomInset > 0 ? bottomInset + 40 : 110.0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.base,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          context.pagePadding.top - 20,
          context.pagePadding.left,
          // context.pagePadding.bottom,0
          0,
        ),
        child: ListView(
          children: [
            HeaderWidget(
              title: "Details",
              showactions: true,
              actions: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  AppButton.iconButton(
                    buttonColor: AppColor.transparent,
                    padding: EdgeInsets.all(0),
                    iconPath: AppAsset.share,
                    isResponsiveHeight: true,
                    isResponsiveWidth: true,
                    fontColor: AppColor.black,
                  ),
                  AppButton.iconButton(
                    buttonColor: AppColor.transparent,
                    padding: EdgeInsets.all(0),
                    iconPath: AppAsset.favourite,
                    isResponsiveHeight: true,
                    isResponsiveWidth: true,
                    fontColor: AppColor.black,
                  ),
                ],
              ),
            ),
            20.heightBox,
            PropertyGallary(gallary: gallary),
            20.heightBox,
            PropertyTitle(),
            bottomSpacing.heightBox,
          ],
        ),
      ),
    );
  }
}

class PropertyTitle extends StatelessWidget {
  const PropertyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Content(
                data: 'House of Mormon',
                textStyle: context.headingText.copyWith(
                  fontWeight: AppFontWeight.semiBold,
                ),
                size: 20,
              ),
              IconList(
                weight: AppFontWeight.medium,
                color: AppColor.baseText,
                data: 'Denpasar, Bali',
                icon: AppImage.svg(svgPath: AppAsset.locationIcon,size: 20,svgColor: AppColor.baseText,),
              ),
            ],
          ),
        ),
        RichText(
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
      ],
    );
  }
}

class PropertyGallary extends StatefulWidget {
  final List<String> gallary;
  const PropertyGallary({super.key, required this.gallary});

  @override
  State<PropertyGallary> createState() => _PropertyGallaryState();
}

class _PropertyGallaryState extends State<PropertyGallary> {
  int selectedIndex = 0;

  void _increment() {
    if (selectedIndex != widget.gallary.length - 1) {
      setState(() {
        selectedIndex++;
      });
    }
  }

  void _decrement() {
    if (selectedIndex != 0) {
      setState(() {
        selectedIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: AppImage.asset(
                    assetPath: widget.gallary[selectedIndex],
                  ),
                ),

                if (selectedIndex > 0) ...[
                  Positioned(
                    left: 5,

                    // bottom: 10,
                    child: AppButton.iconButton(
                      onTap: () => _decrement(),
                      padding: EdgeInsets.all(5),
                      iconPath: AppAsset.back,
                      isResponsiveHeight: true,
                      isResponsiveWidth: true,
                    ),
                  ),
                ],
                if (selectedIndex != widget.gallary.length - 1) ...[
                  Positioned(
                    right: 5,
                    // bottom: 10,
                    child: AppButton.iconButton(
                      onTap: () => _increment(),
                      padding: EdgeInsets.all(5),
                      iconPath: AppAsset.forward,
                      isResponsiveHeight: true,
                      isResponsiveWidth: true,
                    ),
                  ),
                ],
                Positioned(
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Pagination(
                      currentPage: selectedIndex,
                      totalPages: widget.gallary.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        5.heightBox,
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: isSelected
                        ? Border.all(width: 1.5, color: AppColor.primary)
                        : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AppImage.asset(
                      size: 72,
                      assetPath: widget.gallary[index],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return 5.widthBox;
            },
            itemCount: widget.gallary.length,
          ),
        ),
      ],
    );
  }
}
