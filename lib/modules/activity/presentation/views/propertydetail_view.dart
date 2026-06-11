import 'package:flutter/gestures.dart';
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
import 'package:taxi_app/modules/activity/presentation/widget/propert_detail_card.dart';
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
            20.heightBox,
            PropertyDetails(),
            20.heightBox,
            Description(),
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
                icon: AppImage.svg(
                  svgPath: AppAsset.locationIcon,
                  size: 20,
                  svgColor: AppColor.baseText,
                ),
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

class PropertyDetails extends StatelessWidget {
  const PropertyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PropertyDetailEntity> detailList = [
      PropertyDetailEntity(title: 'Bedrooms', value: '3', icon: AppAsset.bed),
      PropertyDetailEntity(title: 'Bathub', value: '2', icon: AppAsset.bath),
      PropertyDetailEntity(
        title: 'Area',
        value: '1,880 sqft',
        icon: AppAsset.area,
      ),
      PropertyDetailEntity(title: 'Build', value: '2020', icon: ""),
      PropertyDetailEntity(title: 'Parking', value: '1 Indoor', icon: ""),
      PropertyDetailEntity(title: 'Status', value: 'Rent', icon: ""),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 20,
      children: [
        Content(
          data: 'Property Details',
          textStyle: context.headingText.copyWith(
            fontWeight: AppFontWeight.semiBold,
          ),
          size: 18,
        ),
        GridView.builder(
          shrinkWrap: true,

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2,
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return PropertDetailCard(entity: detailList[index]);
          },
          itemCount: detailList.length,
        ),
      ],
    );
  }
}

class Description extends StatefulWidget {
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  static const String _description =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. 1500s, when an unknown printer took when an unknown printer took a type.Lorem Ipsum is simply dummy text of the printing and typesetting industry. 1500s, when an unknown printer took when an unknown printer took a type.';

  bool readMore = false;
  late final TapGestureRecognizer _readMoreRecognizer;

  @override
  void initState() {
    super.initState();
    _readMoreRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          readMore = !readMore;
        });
      };
  }

  @override
  void dispose() {
    _readMoreRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final descriptionStyle = context.bodyText.copyWith(
      color: AppColor.baseText,
      fontWeight: AppFontWeight.medium,
      fontSize: 14,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 20,
      children: [
        Content(
          data: 'Description',
          textStyle: context.headingText.copyWith(
            fontWeight: AppFontWeight.semiBold,
          ),
          size: 18,
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final linkText = readMore ? ' Read less' : ' Read more';
            final visibleDescription = readMore
                ? _description
                : _truncatedDescription(
                    maxWidth: constraints.maxWidth,
                    textStyle: descriptionStyle,
                    linkStyle: descriptionStyle.copyWith(color: AppColor.btnBg),
                    textScaler: MediaQuery.textScalerOf(context),
                  );

            return RichText(
              text: TextSpan(
                text: visibleDescription,
                style: descriptionStyle,
                children: [
                  TextSpan(
                    text: linkText,
                    style: descriptionStyle.copyWith(color: AppColor.btnBg),
                    recognizer: _readMoreRecognizer,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  String _truncatedDescription({
    required double maxWidth,
    required TextStyle textStyle,
    required TextStyle linkStyle,
    required TextScaler textScaler,
  }) {
    const readMoreText = ' Read more';
    const dots = '.....';

    var low = 0;
    var high = _description.length;
    var result = _description;

    while (low <= high) {
      final mid = (low + high) ~/ 2;
      final candidate = '${_description.substring(0, mid).trimRight()}$dots';

      final painter = TextPainter(
        maxLines: 3,
        textDirection: TextDirection.ltr,
        textScaler: textScaler,
        text: TextSpan(
          text: candidate,
          style: textStyle,
          children: [TextSpan(text: readMoreText, style: linkStyle)],
        ),
      )..layout(maxWidth: maxWidth);

      if (painter.didExceedMaxLines) {
        high = mid - 1;
      } else {
        result = candidate;
        low = mid + 1;
      }
    }

    return result;
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
