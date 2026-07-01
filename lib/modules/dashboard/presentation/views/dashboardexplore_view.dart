import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/shimmer/app_shimmer.dart';
import 'package:taxi_app/core/network/api_status.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/store/store_preference.dart';
import 'package:taxi_app/core/store/user_store_key.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_snackBar.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardexplore_param.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardexplore/dashboardexplore_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/popular_place_card.dart';

class DashboardexploreView extends StatefulWidget {
  final DashboardexploreBloc bloc;
  final String? title;
  const DashboardexploreView({super.key, required this.bloc, this.title});

  @override
  State<DashboardexploreView> createState() => _DashboardexploreViewState();
}

class _DashboardexploreViewState extends State<DashboardexploreView> {
  final token = StorePreference()
      .read<String>(UserStoreKey.accessToken)
      .getOrElse((_) => '');

  @override
  void initState() {
    super.initState();
    _loadExploreData();
  }

  @override
  void didUpdateWidget(covariant DashboardexploreView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.title != widget.title || oldWidget.bloc != widget.bloc) {
      _loadExploreData();
    }
  }

  void _loadExploreData() {
    widget.bloc.add(
      LoadDashboardexploreEvent(
        DashboardexploreParam(
          token: token,
          type: _mapTitleToType(widget.title),
        ),
      ),
    );
  }

  String _mapTitleToType(String? title) {
    switch (title?.trim().toLowerCase()) {
      case 'nearby':
        return 'nearby';
      case 'popular places':
        return 'popular';
      case 'top locations':
        return 'top-locations';
      case 'recommended':
      default:
        return 'recommended';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final bottomSpacing = bottomInset > 0 ? bottomInset + 40 : 110.0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.white,
      body: BlocConsumer<DashboardexploreBloc, DashboardexploreState>(
        bloc: widget.bloc,
        listenWhen: (previous, current) =>
            previous.dashboardexploreResponse != current.dashboardexploreResponse,
        buildWhen: (previous, current) =>
            previous.dashboardexploreResponse != current.dashboardexploreResponse,
        listener: (context, state) {
          if (state.dashboardexploreResponse.status == ApiStatus.error) {
            context.showSnackbar(
              message:
                  state.dashboardexploreResponse.message ?? 'Something went wrong',
            );
          }
        },
        builder: (context, state) {
          final response = state.dashboardexploreResponse;
          final properties = response.data?.data.data ?? const <PropertyEntity>[];
          final isLoading =
              response.status == ApiStatus.init ||
              response.status == ApiStatus.loading;

          return Padding(
            padding: EdgeInsets.fromLTRB(
              context.pagePadding.left,
              context.pagePadding.top - 20,
              context.pagePadding.left,
              0,
            ),
            child: ListView(
              children: [
                HeaderWidget(
                  showBackButton: false,
                  title: widget.title ?? 'Explore',
                ),
                30.heightBox,
                ExploreListingSection(
                  properties: properties,
                  isLoading: isLoading,
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

class ExploreListingSection extends StatelessWidget {
  final List<PropertyEntity> properties;
  final bool isLoading;

  const ExploreListingSection({
    super.key,
    required this.properties,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return const AppShimmer.card(height: 80, width: double.infinity);
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
            height: 20,
            color: AppColor.baseText.withValues(alpha: 0.2),
          );
        },
        itemCount: 5,
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return PopularPlaceCard(propertyData: properties[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 1,
          height: 20,
          color: AppColor.baseText.withValues(alpha: 0.2),
        );
      },
      itemCount: properties.length,
    );
  }
}
