import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardprofile/dashboardprofile_bloc.dart';
// import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/setting_list_tile.dart';

class DashboardprofileView extends StatefulWidget {
  final DashboardprofileBloc bloc;
  const DashboardprofileView({super.key, required this.bloc});

  @override
  State<DashboardprofileView> createState() => _DashboardprofileViewState();
}

class _DashboardprofileViewState extends State<DashboardprofileView> {
  @override
  void initState() {
    super.initState();
  }

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
            HeaderWidget(title: 'Profile'),
            30.heightBox,
            ProfileHeader(),
            30.heightBox,
            Divider(
              thickness: 1,
              color: AppColor.baseText.withValues(alpha: 0.5),
            ),
            30.heightBox,
            SettingListTile(title: 'Setting', icon: AppAsset.setting),
            10.heightBox,
            SettingListTile(title: 'Payment', icon: AppAsset.wallet),
            10.heightBox,
            SettingListTile(title: 'Notification', icon: AppAsset.notification),
            10.heightBox,
            SettingListTile(title: 'Recent Viewed', icon: AppAsset.recentView),
            10.heightBox,
            SettingListTile(title: 'About', icon: AppAsset.about),
            10.heightBox,
            bottomSpacing.heightBox,
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        AvaterWidget(),
        10.heightBox,
        Content(
          data: 'Sohaib Nawaz',
          textStyle: context.bodyText.copyWith(
            fontWeight: AppFontWeight.semiBold,
            color: AppColor.primaryText,
          ),
          size: 22,
        ),
        5.heightBox,
        Content(
          data: 'Sohaibnawaz2000@gmail.com',
          textStyle: context.bodyText.copyWith(
            fontWeight: AppFontWeight.medium,
            color: AppColor.primaryText,
          ),
          size: 14,
        ),
      ],
    );
  }
}

class AvaterWidget extends StatelessWidget {
  const AvaterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        CircleAvatar(radius: 48, backgroundColor: AppColor.highlight),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColor.btnBg,
            child: AppImage.svg(svgPath: AppAsset.camera, size: 16),
          ),
        ),
      ],
    );
  }
}
