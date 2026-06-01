import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardbooking/dashboardbooking_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/booking_card.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/custom_tab.dart';

class DashboardbookingView extends StatefulWidget {
  final DashboardbookingBloc bloc;
  const DashboardbookingView({super.key, required this.bloc});

  @override
  State<DashboardbookingView> createState() => _DashboardbookingViewState();
}

class _DashboardbookingViewState extends State<DashboardbookingView> {
  int currentIndex = 0;
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
      backgroundColor: AppColor.white,
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
            HeaderWidget(showBackButton: false, title: 'Booking'),
            30.heightBox,
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColor.baseText.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(BookingStatus.values.length, (index) {
                  return CustomBookingTab(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    data: BookingStatus.values[index],
                    isSelected: currentIndex == index,
                  );
                }),
              ),
            ),
            // FavouriteListingSection(),
            bottomSpacing.heightBox,
          ],
        ),
      ),
    );
  }
}
