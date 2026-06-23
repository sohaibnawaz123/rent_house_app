import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/location_utils.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardroot/dashboardroot_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardroot_view_initial_params.dart';
import 'package:taxi_app/modules/dashboard/presentation/views/dashboardroot_view.dart';
import 'package:taxi_app/modules/googlemap/data/model/response/locationpick_model/locationpick_model.dart';
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
  bool _isPickingCurrentLocation = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _useCurrentLocation() async {
    if (_isPickingCurrentLocation) return;

    setState(() => _isPickingCurrentLocation = true);

    try {
      final position = await pickCurrentLocation();

      if (!mounted) return;

      context.pushPage(
        LocationpickView(
          bloc: getIt<LocationpickBloc>(
            param1: LocationpickViewInitialParams(
              latitude: position.latitude,
              longitude: position.longitude,
            ),
          ),
        ),
      );
    } on CurrentLocationException catch (error) {
      if (!mounted) return;
      Utils.toastErrMessage(error.message, context);
    } catch (_) {
      if (!mounted) return;
      Utils.toastErrMessage('Unable to pick current location.', context);
    } finally {
      if (mounted) {
        setState(() => _isPickingCurrentLocation = false);
      }
    }
  }

  void _selectManually() {
    context.pushPage(
      LocationpickView(
        bloc: getIt<LocationpickBloc>(
          param1: const LocationpickViewInitialParams(),
        ),
      ),
    );
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
              actions: AppButton(
                onTap: () {
                  context.pushReplacementPage(
                    DashboardrootView(
                      bloc: getIt<DashboardrootBloc>(
                        param1: const DashboardrootViewInitialParams(
                          location: LocationpickModel(
                            lat: 0,
                            lon: 0,
                            city: '',
                            state: '',
                            country: '',
                            zipcode: '',
                            addressline:
                                'Select the address for better results',
                            countrycode: '',
                            provincecode: '',
                          ),
                        ),
                      ),
                    ),
                  );
                },
                title: 'Skip',
                buttonColor: AppColor.transparent,
                // height: 40,
                isResponsiveHeight: true,
                isResponsiveWidth: true,
                borderColor: AppColor.borderColor,
                radius: 20,
                fontColor: AppColor.baseText,
                fontSize: 14,
                borderWidth: 1.5,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              ),
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
              isLoading: _isPickingCurrentLocation,
              onTap: _useCurrentLocation,
            ),
            20.heightBox,
            AppButton(
              title: 'Select it manually',
              buttonColor: AppColor.transparent,
              borderColor: AppColor.btnBg,
              fontColor: AppColor.btnBg,
              onTap: _selectManually,
            ),
          ],
        ),
      ),
    );
  }
}
