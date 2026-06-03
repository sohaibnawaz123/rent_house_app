import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
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
    final bottomSpacing = bottomInset > 0 ? bottomInset + 40 : 160.0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          context.pagePadding.top,
          context.pagePadding.left,
          // context.pagePadding.bottom,0
          0,
        ),
        child: Column(
          children: [
            HeaderWidget(showBackButton: false, title: 'Booking'),
            30.heightBox,
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColor.baseText.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(5),
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
            20.heightBox,
            Expanded(
              child: BookingListingSection(
                selectedIndex: currentIndex,
                bottomSpacing: bottomSpacing,
              ),
            ),
            // FavouriteListingSection(),
          ],
        ),
      ),
    );
  }
}

class BookingListingSection extends StatefulWidget {
  final int selectedIndex;
  final double bottomSpacing;
  const BookingListingSection({
    super.key,
    required this.selectedIndex,
    required this.bottomSpacing,
  });

  @override
  State<BookingListingSection> createState() => _BookingListingSectionState();
}

class _BookingListingSectionState extends State<BookingListingSection> {
  bool showNotFound = true;

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void didUpdateWidget(covariant BookingListingSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    // When tab changes → reset delay
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      setState(() {
        showNotFound = true;
      });
      _startDelay();
    }
  }

  void _startDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showNotFound = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showNotFound) {
      return const Center(
        // 👈 better UI
        child: NotFoundSection(),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(bottom: widget.bottomSpacing),
      itemBuilder: (context, index) {
        return BookingCard(
          bookingStatus: BookingStatus.values[widget.selectedIndex],
          bookedStatus: widget.selectedIndex == 1
              ? BookedStatus.completed
              : widget.selectedIndex == 2
              ? BookedStatus.cancelled
              : BookedStatus.waitingpayment,
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 30,
          thickness: 1,
          color: AppColor.baseText.withValues(alpha: 0.25),
        );
      },
      itemCount: 5,
    );
  }
}

class NotFoundSection extends StatelessWidget {
  const NotFoundSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    // print(bottomInset);
    final bottomSpacing = bottomInset > 0 ? bottomInset + 40 : 160.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: AppImage.svg(
            svgPath: AppAsset.opps,
            size: MediaQuery.of(context).size.width,
          ),
        ),
        Content(
          data: 'You have no upcoming booking',
          textStyle: context.headingText,
          size: 22,
        ),
        20.heightBox,
        Content(
          data: 'are you looking fo a completed or cancelled booking ?',
          textStyle: context.bodyText,
          alignment: TextAlign.center,
        ),
        bottomSpacing.heightBox
      ],
    );
  }
}
