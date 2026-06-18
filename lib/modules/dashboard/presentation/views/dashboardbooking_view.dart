import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/shimmer/app_shimmer.dart';
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
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    final bottomSpacing = bottomInset > 0 ? bottomInset + 40 : 160.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          context.pagePadding.top,
          context.pagePadding.left,
          0,
        ),
        child: Column(
          children: [
            HeaderWidget(showBackButton: false, title: 'Booking'),

            30.heightBox,

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
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
                    data: BookingStatus.values[index].name,
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
  bool isLoading = true;

  /// Change this according to API response
  final bool hasBookings = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  @override
  void didUpdateWidget(covariant BookingListingSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _startLoading();
    }
  }

  void _startLoading() {
    _timer?.cancel();

    setState(() {
      isLoading = true;
    });

    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Loading State
    if (isLoading) {
      return ListView.separated(
        itemBuilder: (content, index) {
          return AppShimmer.card(height: 100);
        },
        separatorBuilder: (context, index) {
          return 10.heightBox;
        },
        itemCount: 10,
      );
    }

    /// List State
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
    return Column(
      mainAxisSize: MainAxisSize.min,
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
          data: 'Are you looking for a completed or cancelled booking?',
          textStyle: context.bodyText,
          alignment: TextAlign.center,
        ),
      ],
    );
  }
}
