import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/modules/googlemap/presentation/blocs/locationpick/locationpick_bloc.dart';
import 'package:taxi_app/modules/googlemap/presentation/blocs/locationselection/locationselection_bloc.dart';
import 'package:taxi_app/modules/googlemap/presentation/routes/locationpick_view_initial_params.dart';
import 'package:taxi_app/modules/googlemap/presentation/views/locationpick_view.dart';

class LocationselectionView extends StatefulWidget {
  final LocationselectionBloc bloc;
  const LocationselectionView({super.key, required this.bloc});

  @override
  State<LocationselectionView> createState() => _LocationselectionViewState();
}

class _LocationselectionViewState extends State<LocationselectionView> {
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
          context.pagePadding.top,
          context.pagePadding.left,
          context.pagePadding.bottom,
        ),
        child: Column(
          children: [
            HeaderWidget(
              showactions: true,
              actions: [
                AppButton(
                  title: 'Skip',
                  buttonColor: AppColor.transparent,
                  // height: 40,
                  // isResponsiveHeight: true,
                  isResponsiveWidth: true,
                  borderColor: AppColor.borderColor,
                  radius: 20,
                  fontColor: AppColor.baseText,
                  fontSize: 14,
                  borderWidth: 1.5,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ],
            ),
            SizedBox(
              child: AppImage.svg(
                svgPath: AppAsset.map,
                size: MediaQuery.of(context).size.width,
              ),
            ),
            Content(
              data: 'Hi, Nice to meet you !',
              textStyle: context.headingText,
              size: 22,
            ),
            20.heightBox,
            Content(
              data: 'Choose your location to find property around you',
              textStyle: context.bodyText,
              alignment: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          // context.pagePadding.top,
          0,
          context.pagePadding.left,
          context.pagePadding.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              title: 'Use current location',
              onTap: () => context.pushPage(
                LocationpickView(
                  bloc: getIt<LocationpickBloc>(
                    param1: LocationpickViewInitialParams(),
                  ),
                ),
              ),
            ),
            20.heightBox,
            AppButton(
              title: 'Select it manually',
              buttonColor: AppColor.transparent,
              borderColor: AppColor.btnBg,
              fontColor: AppColor.btnBg,
            ),
          ],
        ),
      ),
    );
  }
}
