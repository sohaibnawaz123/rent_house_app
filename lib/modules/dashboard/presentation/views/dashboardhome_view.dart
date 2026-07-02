import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/shimmer/app_shimmer.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/component/text_field/content_field.dart';
import 'package:taxi_app/core/network/api_status.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/store/store_preference.dart';
import 'package:taxi_app/core/store/user_store_key.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_snackBar.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/modules/activity/presentation/blocs/propertydetail/propertydetail_bloc.dart';
import 'package:taxi_app/modules/activity/presentation/routes/propertydetail_view_initial_params.dart';
import 'package:taxi_app/modules/activity/presentation/views/propertydetail_view.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/top_location_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardroot_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardhome_param.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardhome/dashboardhome_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardroot/dashboardroot_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/near_by_card.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/popular_place_card.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/recommended_property_card.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/top_location_card.dart';
import 'package:taxi_app/modules/googlemap/data/model/response/locationpick_model/locationpick_model.dart';
import 'package:taxi_app/modules/googlemap/presentation/blocs/locationselection/locationselection_bloc.dart';
import 'package:taxi_app/modules/googlemap/presentation/routes/locationselection_view_initial_params.dart';
import 'package:taxi_app/modules/googlemap/presentation/views/locationselection_view.dart';

class DashboardhomeView extends StatefulWidget {
  final DashboardhomeBloc bloc;
  const DashboardhomeView({super.key, required this.bloc});

  @override
  State<DashboardhomeView> createState() => _DashboardhomeViewState();
}

class _DashboardhomeViewState extends State<DashboardhomeView> {
  final token = StorePreference()
      .read<String>(UserStoreKey.accessToken)
      .getOrElse((_) => '');
  @override
  void initState() {
    super.initState();
    widget.bloc.add(LoadDashboardhomeEvent(DashboardhomeParam(token: token)));
    widget.bloc.add(
      LoadDashboardhomeAddressEvent(DashboardhomeParam(token: token)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    // print(bottomInset);
    final bottomSpacing = bottomInset > 0 ? bottomInset + 40 : 110.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      // extendBody: false,
      backgroundColor: AppColor.white,
      body: BlocConsumer<DashboardhomeBloc, DashboardhomeState>(
        bloc: widget.bloc,
        listenWhen: (previous, current) =>
            current.dashboardhomeResponse != previous.dashboardhomeResponse ||
            current.dashboardhomeadressResponse !=
                previous.dashboardhomeadressResponse,
        buildWhen: (previous, current) =>
            current.dashboardhomeResponse != previous.dashboardhomeResponse ||
            current.dashboardhomeadressResponse !=
                previous.dashboardhomeadressResponse,
        listener: (context, state) {
          if (state.dashboardhomeResponse.status == ApiStatus.error) {
            context.showSnackbar(
              message:
                  state.dashboardhomeResponse.message ?? "Something went wrong",
            );
          }
          if (state.dashboardhomeadressResponse.status == ApiStatus.error) {
            context.showSnackbar(
              message:
                  state.dashboardhomeadressResponse.message ??
                  "Something went wrong",
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              context.pagePadding.left,
              context.pagePadding.top - 20,
              context.pagePadding.left,
              // context.pagePadding.bottom,0
              0,
            ),
            child: ListView(
              children: [
                HomeHeader(
                  ontap: () {
                    context.pushPage(
                      LocationselectionView(
                        bloc: getIt<LocationselectionBloc>(
                          param1: const LocationselectionViewInitialParams(
                            isPop: true,
                          ),
                        ),
                      ),
                      then: (result) {
                        if (result is! LocationpickModel) return;

                        widget.bloc.add(
                          LoadDashboardhomeAddressEvent(
                            DashboardhomeParam(token: token),
                          ),
                        );
                      },
                    );
                  },
                  isLoading:
                      state.dashboardhomeadressResponse.status ==
                          ApiStatus.init ||
                      state.dashboardhomeadressResponse.status ==
                          ApiStatus.loading,
                  address:
                      state.dashboardhomeadressResponse.data?.data.addressline,
                ),
                20.heightBox,
                SearchFeild(),
                20.heightBox,
                OfferCard(),
                20.heightBox,
                RecommendedLocations(
                  isLoading:
                      state.dashboardhomeResponse.status == ApiStatus.init ||
                      state.dashboardhomeResponse.status == ApiStatus.loading,
                  recommendedProperty:
                      state.dashboardhomeResponse.data?.data.recommended ?? [],
                ),
                if (state.dashboardhomeResponse.status == ApiStatus.loading ||
                    (state.dashboardhomeResponse.data?.data.nearby.isNotEmpty ??
                        false)) ...[
                  20.heightBox,
                  NearBySection(
                    isLoading:
                        state.dashboardhomeResponse.status == ApiStatus.init ||
                        state.dashboardhomeResponse.status == ApiStatus.loading,
                    nearByProperty:
                        state.dashboardhomeResponse.data?.data.nearby ?? [],
                  ),
                ],
                20.heightBox,
                TopLocationSection(
                  isLoading:
                      state.dashboardhomeResponse.status == ApiStatus.init ||
                      state.dashboardhomeResponse.status == ApiStatus.loading,
                  topLocation:
                      state.dashboardhomeResponse.data?.data.topLocations ?? [],
                ),
                20.heightBox,
                PopularPlaceSection(
                  isLoading:
                      state.dashboardhomeResponse.status == ApiStatus.init ||
                      state.dashboardhomeResponse.status == ApiStatus.loading,
                  popularProperty:
                      state.dashboardhomeResponse.data?.data.popularForYou ??
                      [],
                ),
                bottomSpacing.heightBox,
              ],
            ),
          );
        },
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  final String? address;
  final bool isLoading;
  final void Function()? ontap;
  const HomeHeader({
    super.key,
    this.address,
    required this.isLoading,
    this.ontap,
  });

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
              isLoading
                  ? AppShimmer.text()
                  : IconList(
                      onTap: ontap,
                      isCenter: false,
                      // isLeft: false,
                      // ignore: dead_null_aware_expression
                      data: address ?? 'Select the address or better places',
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
  final bool isLoading;
  final List<PropertyEntity> recommendedProperty;
  const RecommendedLocations({
    super.key,
    required this.recommendedProperty,
    required this.isLoading,
  });

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
            GestureDetector(
              onTap: () {
                context.read<DashboardrootBloc>().add(
                  ChangeNavigationEvent(
                    NavItemEntity.explore,
                    title: 'Recommended',
                  ),
                );
              },
              child: Content(
                data: 'See All',
                textStyle: context.bodyText.copyWith(color: AppColor.primary),
                size: 14,
              ),
            ),
          ],
        ),
        20.heightBox,
        SizedBox(
          height: 165,
          child: widget.isLoading
              ? ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const AppShimmer.card(width: 225, height: 165);
                  },
                  separatorBuilder: (context, index) {
                    return 10.widthBox;
                  },
                  itemCount: 3,
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return RecommendedPropertyCard(
                      onTap: () => context.pushPage(
                        PropertydetailView(
                          bloc: getIt<PropertydetailBloc>(
                            param1: PropertydetailViewInitialParams(
                              propertyId: widget.recommendedProperty[index].id,
                            ),
                          ),
                        ),
                      ),
                      propertyData: widget.recommendedProperty[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return 10.widthBox;
                  },
                  itemCount: widget.recommendedProperty.length,
                ),
        ),
      ],
    );
  }
}

class NearBySection extends StatefulWidget {
  final bool isLoading;
  final List<PropertyEntity> nearByProperty;
  const NearBySection({
    super.key,
    required this.isLoading,
    required this.nearByProperty,
  });

  @override
  State<NearBySection> createState() => _NearBySectionState();
}

class _NearBySectionState extends State<NearBySection> {
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
              data: 'Nearby',
              textStyle: context.headingText.copyWith(
                color: AppColor.primaryText,
              ),
              size: 18,
            ),
            GestureDetector(
              onTap: () {
                context.read<DashboardrootBloc>().add(
                  ChangeNavigationEvent(NavItemEntity.explore, title: 'Nearby'),
                );
              },
              child: Content(
                data: 'See All',
                textStyle: context.bodyText.copyWith(color: AppColor.primary),
                size: 14,
              ),
            ),
          ],
        ),
        20.heightBox,
        SizedBox(
          height: 180,
          child: widget.isLoading
              ? GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 rows
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.37, // controls card width
                  ),
                  itemBuilder: (context, index) {
                    return AppShimmer.card(height: 180, width: 200);
                  },
                )
              : GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.nearByProperty.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 rows
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.37, // controls card width
                  ),
                  itemBuilder: (context, index) {
                    return NearByCard(data: widget.nearByProperty[index]);
                  },
                ),
        ),
      ],
    );
  }
}

class TopLocationSection extends StatefulWidget {
  final bool isLoading;
  final List<TopLocationEntity> topLocation;
  const TopLocationSection({
    super.key,
    required this.isLoading,
    required this.topLocation,
  });

  @override
  State<TopLocationSection> createState() => _TopLocationSectionState();
}

class _TopLocationSectionState extends State<TopLocationSection> {
  int selectedIndex = -1;

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
              data: 'Top Locations',
              textStyle: context.headingText.copyWith(
                color: AppColor.primaryText,
              ),
              size: 18,
            ),
            GestureDetector(
              onTap: () {
                context.read<DashboardrootBloc>().add(
                  ChangeNavigationEvent(
                    NavItemEntity.explore,
                    title: 'Top Locations',
                  ),
                );
              },
              child: Content(
                data: 'See All',
                textStyle: context.bodyText.copyWith(color: AppColor.primary),
                size: 14,
              ),
            ),
          ],
        ),
        20.heightBox,
        SizedBox(
          height: 50,
          child: widget.isLoading
              ? ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return AppShimmer.card(height: 50, width: 100);
                  },
                  separatorBuilder: (context, index) {
                    return 10.widthBox;
                  },
                  itemCount: 10,
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TopLocationCard(
                      data: widget.topLocation[index],
                      isSelected: selectedIndex == index,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return 10.widthBox;
                  },
                  itemCount: widget.topLocation.length,
                ),
        ),
      ],
    );
  }
}

class PopularPlaceSection extends StatelessWidget {
  final List<PropertyEntity> popularProperty;
  final bool isLoading;
  const PopularPlaceSection({
    super.key,
    required this.popularProperty,
    required this.isLoading,
  });

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
              data: 'Popular Places',
              textStyle: context.headingText.copyWith(
                color: AppColor.primaryText,
              ),
              size: 18,
            ),
            GestureDetector(
              onTap: () {
                context.read<DashboardrootBloc>().add(
                  ChangeNavigationEvent(
                    NavItemEntity.explore,
                    title: 'Popular Places',
                  ),
                );
              },
              child: Content(
                data: 'See All',
                textStyle: context.bodyText.copyWith(color: AppColor.primary),
                size: 14,
              ),
            ),
          ],
        ),
        20.heightBox,
        isLoading
            ? ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return AppShimmer.card(height: 80, width: double.infinity);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 1,
                    height: 20,
                    color: AppColor.baseText.withValues(alpha: 0.2),
                  );
                },
                itemCount: 5,
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return PopularPlaceCard(propertyData: popularProperty[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 1,
                    height: 20,
                    color: AppColor.baseText.withValues(alpha: 0.2),
                  );
                },
                itemCount: popularProperty.length,
              ),
      ],
    );
  }
}
