import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/component/text_field/content_field.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/store/store_preference.dart';
import 'package:taxi_app/core/store/user_store_key.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardroot/dashboardroot_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardroot_view_initial_params.dart';
import 'package:taxi_app/modules/dashboard/presentation/views/dashboardroot_view.dart';
import 'package:taxi_app/modules/googlemap/presentation/blocs/locationpick/locationpick_bloc.dart';

class LocationpickView extends StatefulWidget {
  final LocationpickBloc bloc;
  const LocationpickView({super.key, required this.bloc});

  @override
  State<LocationpickView> createState() => _LocationpickViewState();
}

class _LocationpickViewState extends State<LocationpickView> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(InitializeLocationpickEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: false,
        backgroundColor: AppColor.base,
        body: Stack(
          children: [
            const GoogleMapBackground(),
            Positioned(
              top: context.pagePadding.top,
              left: context.pagePadding.left,
              right: context.pagePadding.left,
              child: const LocationSearchHeader(),
            ),
            Positioned(
              bottom: context.pagePadding.bottom,
              left: context.pagePadding.left,
              right: context.pagePadding.left,
              child: const LocationBottomCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleMapBackground extends StatefulWidget {
  const GoogleMapBackground({super.key});

  @override
  State<GoogleMapBackground> createState() => _GoogleMapBackgroundState();
}

class _GoogleMapBackgroundState extends State<GoogleMapBackground> {
  GoogleMapController? _mapController;
  late final Future<BitmapDescriptor> _markerIconFuture;

  @override
  void initState() {
    super.initState();
    _markerIconFuture = _bitmapDescriptorFromSvgAsset(AppAsset.marker);
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
    String assetName, {
    int width = 68,
    int height = 68,
  }) async {
    try {
      final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);
      final image = await pictureInfo.picture.toImage(width, height);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      pictureInfo.picture.dispose();
      image.dispose();

      final bytes = byteData?.buffer.asUint8List();
      if (bytes == null) return BitmapDescriptor.defaultMarker;

      return BitmapDescriptor.bytes(bytes);
    } catch (_) {
      return BitmapDescriptor.defaultMarker;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationpickBloc, LocationpickState>(
      listenWhen: (previous, current) =>
          previous.selectedPlaceVersion != current.selectedPlaceVersion,
      listener: (context, state) {
        final selectedLocation = state.selectedLocation;
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(selectedLocation.lat, selectedLocation.lon),
          ),
        );
      },
      child: FutureBuilder<BitmapDescriptor>(
        future: _markerIconFuture,
        builder: (context, snapshot) {
          final markerIcon = snapshot.data ?? BitmapDescriptor.defaultMarker;

          return BlocBuilder<LocationpickBloc, LocationpickState>(
            buildWhen: (previous, current) =>
                previous.selectedLocation.lat != current.selectedLocation.lat ||
                previous.selectedLocation.lon != current.selectedLocation.lon,
            builder: (context, state) {
              final selectedLocation = state.selectedLocation;
              final selectedPosition = LatLng(
                selectedLocation.lat,
                selectedLocation.lon,
              );

              return GoogleMap(
                onMapCreated: (controller) => _mapController = controller,
                initialCameraPosition: CameraPosition(
                  target: selectedPosition,
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('selected_location'),
                    position: selectedPosition,
                    icon: markerIcon,
                    anchor: const Offset(0.5, 1),
                    infoWindow: const InfoWindow(title: 'Selected location'),
                  ),
                },
                onCameraMove: (position) {
                  context.read<LocationpickBloc>().add(
                    MapCameraMovedEvent(
                      latitude: position.target.latitude,
                      longitude: position.target.longitude,
                    ),
                  );
                },
                onCameraIdle: () {
                  context.read<LocationpickBloc>().add(MapCameraIdleEvent());
                },
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                compassEnabled: false,
              );
            },
          );
        },
      ),
    );
  }
}

class LocationSearchHeader extends StatefulWidget {
  const LocationSearchHeader({super.key});

  @override
  State<LocationSearchHeader> createState() => _LocationSearchHeaderState();
}

class _LocationSearchHeaderState extends State<LocationSearchHeader> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationpickBloc, LocationpickState>(
      listenWhen: (previous, current) =>
          previous.selectedPlaceVersion != current.selectedPlaceVersion ||
          (previous.searchQuery != current.searchQuery &&
              current.searchQuery.isEmpty),
      listener: (context, state) {
        if (_searchController.text == state.searchQuery) return;
        _searchController.value = TextEditingValue(
          text: state.searchQuery,
          selection: TextSelection.collapsed(offset: state.searchQuery.length),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderWidget(haveBg: true, iconColor: AppColor.primary),
          20.heightBox,
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColor.black.withValues(alpha: 0.12),
                  offset: const Offset(0, 8),
                  blurRadius: 20,
                ),
              ],
            ),
            child: ContentField(
              controller: _searchController,
              hintText: 'Search location',
              hintStyle: context.bodyText.copyWith(
                color: AppColor.baseText,
                fontSize: 14,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColor.primary.withValues(alpha: 0.55),
                size: 28,
              ),
              suffixIcon: BlocBuilder<LocationpickBloc, LocationpickState>(
                buildWhen: (previous, current) =>
                    previous.isSearching != current.isSearching ||
                    previous.searchQuery != current.searchQuery,
                builder: (context, state) {
                  if (state.isSearching) {
                    return const Padding(
                      padding: EdgeInsets.all(14),
                      child: SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }

                  if (state.searchQuery.trim().isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return IconButton(
                    onPressed: () {
                      _searchController.clear();
                      context.read<LocationpickBloc>().add(
                        ClearLocationSearchEvent(),
                      );
                    },
                    icon: Icon(Icons.close, color: AppColor.baseText),
                  );
                },
              ),
              onChanged: (value) {
                context.read<LocationpickBloc>().add(
                  SearchQueryChangedEvent(value),
                );
              },
              filled: true,
              fillColor: AppColor.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              enabledBorder: _searchBorder,
              border: _searchBorder,
              focusedBorder: _searchBorder,
            ),
          ),
          const LocationSuggestionsPanel(),
        ],
      ),
    );
  }

  OutlineInputBorder get _searchBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
  }
}

class LocationSuggestionsPanel extends StatelessWidget {
  const LocationSuggestionsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationpickBloc, LocationpickState>(
      buildWhen: (previous, current) =>
          previous.suggestions != current.suggestions ||
          previous.searchQuery != current.searchQuery ||
          previous.isSearching != current.isSearching,
      builder: (context, state) {
        final showEmptyMessage =
            state.searchQuery.trim().isNotEmpty &&
            !state.isSearching &&
            state.suggestions.isEmpty;

        if (!showEmptyMessage && state.suggestions.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxHeight: 250),
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.borderColor),
            boxShadow: [
              BoxShadow(
                color: AppColor.black.withValues(alpha: 0.10),
                offset: const Offset(0, 8),
                blurRadius: 18,
              ),
            ],
          ),
          child: showEmptyMessage
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Content(
                    data: 'No location found',
                    textStyle: context.bodyText.copyWith(
                      color: AppColor.baseText,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: state.suggestions.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1, color: AppColor.borderColor),
                  itemBuilder: (context, index) {
                    final suggestion = state.suggestions[index];

                    return InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<LocationpickBloc>().add(
                          SearchSuggestionSelectedEvent(suggestion),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: AppColor.highlight.withValues(
                                  alpha: 0.5,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: AppImage.svg(
                                svgPath: AppAsset.locationIcon,
                                size: 12,
                              ),
                            ),
                            12.widthBox,
                            Expanded(
                              child: Content(
                                data:
                                    "${suggestion.title} , ${suggestion.address}",
                                maxLines: 2,
                                textStyle: context.bodyText.copyWith(
                                  color: AppColor.baseText,
                                  fontSize: 12,
                                ),
                                size: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

class LocationBottomCard extends StatelessWidget {
  const LocationBottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationpickBloc, LocationpickState>(
      buildWhen: (previous, current) =>
          previous.selectedLocation != current.selectedLocation ||
          previous.isResolvingAddress != current.isResolvingAddress,
      builder: (context, state) {
        final selectedLocation = state.selectedLocation;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: context.pagePadding.left,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withValues(alpha: 0.16),
                    offset: const Offset(0, 8),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Content(
                          data: 'Location Details',
                          textStyle: context.headingText.copyWith(
                            color: AppColor.primaryText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (state.isResolvingAddress)
                        const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                    ],
                  ),
                  16.heightBox,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: AppColor.highlight.withValues(alpha: 0.55),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: AppImage.svg(
                            svgPath: AppAsset.locationIcon,
                            size: 26,
                            svgColor: AppColor.primary,
                          ),
                        ),
                      ),
                      12.widthBox,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Content(
                              data: selectedLocation.addressLine,
                              maxLines: 3,
                              textStyle: context.bodyText.copyWith(
                                color: AppColor.primaryText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            8.heightBox,
                            Content(
                              data:
                                  '${selectedLocation.lat.toStringAsFixed(5)}, ${selectedLocation.lon.toStringAsFixed(5)}',
                              textStyle: context.bodyText.copyWith(
                                color: AppColor.baseText,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            16.heightBox,
            AppButton(
              title: 'Choose location',
              buttonColor: AppColor.btnBg,
              isDisable: state.isResolvingAddress,
              onTap: () {
                context.pushPage(
                  DashboardrootView(
                    bloc: getIt<DashboardrootBloc>(
                      param1: DashboardrootViewInitialParams(
                        location: selectedLocation,
                      ),
                    ),
                  ),
                );

                StorePreference().write<Map<String, dynamic>>(
                  UserStoreKey.location,
                  state.selectedLocation.toJson(),
                );
                // Navigator.of(context).pop({
                //   'address': selectedLocation.addressLine,
                //   'latitude': selectedLocation.lat,
                //   'longitude': selectedLocation.lon,
                // });
              },
            ),
          ],
        );
      },
    );
  }
}
