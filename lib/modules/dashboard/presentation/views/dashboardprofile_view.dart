import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/status_tile/status_tile.dart';
import 'package:taxi_app/core/network/api_status.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_snackBar.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/modules/app/presentation/bloc/app_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/login/login_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardprofile/dashboardprofile_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/profile_image_widget.dart';
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
  final LoginBloc loginBloc;

  const DashboardprofileView({
    super.key,
    required this.bloc,
    required this.loginBloc,
  });

  @override
  State<DashboardprofileView> createState() => _DashboardprofileViewState();
}

class _DashboardprofileViewState extends State<DashboardprofileView> {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final bottomSpacing = bottomInset > 0 ? bottomInset + 40 : 110.0;

    return BlocListener<LoginBloc, LoginState>(
      bloc: widget.loginBloc,
      listener: (context, state) {
        if (state.logoutResponse.status == ApiStatus.completed) {
          context.read<AppBloc>().add(const DeleteUserEvent());
          context.showSnackbar(
            message:
                state.logoutResponse.data?.message ?? "Logout Successfully",
            backgroundColor: AppColor.success,
            type: StatusTileType.success,
          );
        }

        if (state.logoutResponse.status == ApiStatus.error) {
          context.showSnackbar(
            message: state.logoutResponse.message ?? "Logout Failed",
            backgroundColor: AppColor.error,
            type: StatusTileType.error,
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColor.base,
        body: Padding(
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
                title: 'Profile',
                showactions: true,
                actions: AppButton.iconButton(
                  isResponsiveHeight: true,
                  isResponsiveWidth: true,
                  iconPath: AppAsset.logout,
                  onTap: () {
                    final accessToken = context.read<AppBloc>().state.accessToken;
                    widget.loginBloc.add(LoadLogoutEvent(accessToken));
                  },
                ),
              ),
              30.heightBox,
              BlocBuilder<DashboardprofileBloc, DashboardprofileState>(
                bloc: widget.bloc,
                builder: (context, state) {
                  return ProfileHeader(
                    onTap: () => widget.bloc.add(PickImageFromGallery()),
                    imageFile: state.image,
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
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final void Function()? onTap;
  final File? imageFile;
  final String? imageUrl;

  const ProfileHeader({super.key, this.onTap, this.imageFile, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AvaterWidget(onTap: onTap, fileImage: imageFile, imageUrl: imageUrl),
        10.heightBox,
      ],
    );
  }
}
