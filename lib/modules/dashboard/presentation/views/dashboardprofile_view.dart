import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/store/store_preference.dart';
import 'package:taxi_app/core/store/user_store_key.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardprofile/dashboardprofile_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/profile_image_widget.dart';
// import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/setting_list_tile.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/about/about_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/editprofile/editprofile_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/notification/notification_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/payment/payment_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/recent/recent_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/routes/about_view_initial_params.dart';
import 'package:taxi_app/modules/setting/presentation/routes/editprofile_view_initial_params.dart';
import 'package:taxi_app/modules/setting/presentation/routes/notification_view_initial_params.dart';
import 'package:taxi_app/modules/setting/presentation/routes/payment_view_initial_params.dart';
import 'package:taxi_app/modules/setting/presentation/routes/recent_view_initial_params.dart';
import 'package:taxi_app/modules/setting/presentation/views/about_view.dart';
import 'package:taxi_app/modules/setting/presentation/views/editprofile_view.dart';
import 'package:taxi_app/modules/setting/presentation/views/notification_view.dart';
import 'package:taxi_app/modules/setting/presentation/views/payment_view.dart';
import 'package:taxi_app/modules/setting/presentation/views/recent_view.dart';

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
            HeaderWidget(
              title: 'Profile',
              showactions: true,
              actions: AppButton.iconButton(
                isResponsiveHeight: true,
                isResponsiveWidth: true,
                iconPath: AppAsset.logout,
                onTap: () => StorePreference().delete(UserStoreKey.isLogin),
              ),
            ),
            30.heightBox,
            BlocBuilder<DashboardprofileBloc, DashboardprofileState>(
              bloc: widget.bloc,
              builder: (context, state) {
                return ProfileHeader(
                  onTap: () => widget.bloc.add(PickImageFromGallery()),
                  imageFile: state.image, // ✅ THIS FIXES YOUR ISSUE
                  // imageUrl: state.dashboardprofileResponse.data?.data.,
                );
              },
            ),
            30.heightBox,
            Divider(
              thickness: 1,
              color: AppColor.baseText.withValues(alpha: 0.5),
            ),
            30.heightBox,
            SettingListTile(
              title: 'Setting',
              icon: AppAsset.setting,
              onTap: () => context.pushPage(
                EditprofileView(
                  bloc: getIt<EditprofileBloc>(
                    param1: EditprofileViewInitialParams(
                      fullname: 'Sohaib Nawaz',
                      userName: 'sohaibnawaz02',
                      email: 'sohaibnawaz@gmail.com',
                    ),
                  ),
                ),
              ),
            ),
            10.heightBox,
            SettingListTile(
              title: 'Payment',
              icon: AppAsset.wallet,
              onTap: () => context.pushPage(
                PaymentView(
                  bloc: getIt<PaymentBloc>(param1: PaymentViewInitialParams()),
                ),
              ),
            ),
            10.heightBox,
            SettingListTile(
              title: 'Notification',
              icon: AppAsset.notification,
              onTap: () => context.pushPage(
                NotificationView(
                  bloc: getIt<NotificationBloc>(
                    param1: NotificationViewInitialParams(),
                  ),
                ),
              ),
            ),
            10.heightBox,
            SettingListTile(
              title: 'Recent Viewed',
              icon: AppAsset.recentView,
              onTap: () => context.pushPage(
                RecentView(
                  bloc: getIt<RecentBloc>(param1: RecentViewInitialParams()),
                ),
              ),
            ),
            10.heightBox,
            SettingListTile(
              title: 'About',
              icon: AppAsset.about,
              onTap: () => context.pushPage(
                AboutView(
                  bloc: getIt<AboutBloc>(param1: AboutViewInitialParams()),
                ),
              ),
            ),
            10.heightBox,
            bottomSpacing.heightBox,
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final void Function()? onTap;
  final File? imageFile; // ✅ CHANGE THIS
  final String? imageUrl; // optional (from API)

  const ProfileHeader({super.key, this.onTap, this.imageFile, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AvaterWidget(
          onTap: onTap,
          fileImage: imageFile, // ✅ LOCAL
          imageUrl: imageUrl, // ✅ NETWORK
        ),
        10.heightBox,
        // your text...
      ],
    );
  }
}
