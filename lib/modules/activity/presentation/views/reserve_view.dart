import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/bottom_sheet/app_bottom_sheet.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/component/text_field/label_text_field.dart';
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
import 'package:taxi_app/modules/activity/presentation/blocs/reserve/reserve_bloc.dart';
import 'package:taxi_app/modules/activity/presentation/widget/calender_widget.dart';
import 'package:taxi_app/modules/activity/presentation/widget/icons_card_widget.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardroot/dashboardroot_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardroot_view_initial_params.dart';
import 'package:taxi_app/modules/dashboard/presentation/views/dashboardroot_view.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/icon_list.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/near_by_card.dart';
import 'package:taxi_app/modules/googlemap/data/model/response/locationpick_model/locationpick_model.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/paymentcard/paymentcard_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/routes/paymentcard_view_initial_params.dart';
import 'package:taxi_app/modules/setting/presentation/views/paymentcard_view.dart';

class ReserveView extends StatefulWidget {
  final ReserveBloc bloc;
  const ReserveView({super.key, required this.bloc});

  @override
  State<ReserveView> createState() => _ReserveViewState();
}

class _ReserveViewState extends State<ReserveView> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  final TextEditingController voucher = TextEditingController();

  LocationpickModel get _defaultLocation => const LocationpickModel(
    lat: 0.0,
    lon: 0.0,
    city: '',
    state: '',
    country: '',
    zipcode: '',
    addressline: '',
    countrycode: '',
    provincecode: '',
  );

  LocationpickModel get _storedLocation {
    return StorePreference()
        .read<Map<String, dynamic>>(UserStoreKey.location)
        .map(LocationpickModel.fromJson)
        .getOrElse((_) => _defaultLocation);
  }

  @override
  void initState() {
    super.initState();
  }

  void openCalenderBottomSheet() async {
    final result = await appBottomSheet(
      context,
      const BookingCalenderWidget(),
      subTitle: 'Select Date',
    );

    if (result != null) {
      setState(() {
        selectedStartDate = result["startDate"];
        selectedEndDate = result["endDate"];
      });
    }
  }

  void openVoucherSheet() async {
    appBottomSheet(
      context,
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LabelTextField(
            labelText: 'Enter a voucher',
            controller: voucher,
            hintText: 'hously0001',
          ),
          20.heightBox,
          AppButton(title: 'Apply', onTap: () => context.popPage()),
        ],
      ),
      subTitle: 'Enter Voucher Code',
    );
  }

  void reservationSuccessBottomSheet() {
    appBottomSheet(
      context,
      Column(
        children: [
          SizedBox(
            child: AppImage.svg(
              svgPath: AppAsset.success,
              size: MediaQuery.of(context).size.width - 150,
            ),
          ),
          20.heightBox,
          Content(
            data: 'Yey, your booking success',
            textStyle: context.headingText,
            size: 22,
          ),
          20.heightBox,
          Content(
            data:
                'you have successfully booked a property, enjoy your property',
            textStyle: context.bodyText,
            alignment: TextAlign.center,
          ),
          20.heightBox,
          AppButton(
            title: 'Explore More',
            onTap: () => context.pushAndRemoveUntilPage(
              DashboardrootView(
                bloc: getIt<DashboardrootBloc>(
                  param1: DashboardrootViewInitialParams(
                    location: _storedLocation,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.white,
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          context.pagePadding.top,
          context.pagePadding.right,
          // context.pagePadding.bottom,
          0,
        ),
        children: [
          HeaderWidget(title: "Booking"),
          30.heightBox,
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 1, color: AppColor.baseText),
            ),
            child: NearByCard(),
          ),
          20.heightBox,
          BookingPeriod(
            onTap: () => openCalenderBottomSheet(),
            selectDate: (selectedStartDate != null && selectedEndDate != null)
                ? "${formatDate(selectedStartDate!)} -> ${formatDate(selectedEndDate!)}"
                : "Select booking date",
          ),
          20.heightBox,
          BookingPayment(
            onTap: () => context.pushPage(
              PaymentcardView(
                bloc: getIt<PaymentcardBloc>(
                  param1: PaymentcardViewInitialParams(),
                ),
              ),
            ),
          ),
          10.heightBox,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: IconList(
                  onTap: () => openVoucherSheet(),
                  size: 16,
                  color: AppColor.black,
                  weight: AppFontWeight.semiBold,
                  isLeft: false,
                  data: 'Enter a voucher',
                  icon: Icon(Icons.add, color: AppColor.black),
                ),
              ),
              Flexible(
                child: Content(
                  data: voucher.text.isEmpty ? "" : voucher.text,
                  size: 16,
                  textStyle: context.headingText.copyWith(
                    color: AppColor.baseText,
                  ),
                ),
              ),
            ],
          ),
          20.heightBox,
          BookingPriceSection(),
          20.heightBox,
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          // context.pagePadding.top - 2,0,
          20,
          context.pagePadding.left,
          context.pagePadding.bottom,

          // 0
        ),
        child: AppButton(
          onTap: () => reservationSuccessBottomSheet(),
          isDisable: selectedEndDate == null && selectedStartDate == null
              ? true
              : false,
          title: 'Confirm and Pay',
        ),
      ),
    );
  }
}

class BookingPeriod extends StatelessWidget {
  final void Function()? onTap;
  final String? selectDate;
  const BookingPeriod({super.key, this.onTap, this.selectDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Content(
          data: 'Period',
          textStyle: context.headingText.copyWith(color: AppColor.primaryText),
          size: 18,
        ),
        15.heightBox,
        IconsCards(
          onTap: onTap,
          prifixIcon: AppAsset.calendar,
          suffixIcon: AppAsset.forward,
          value: selectDate ?? '12 Aug - 12 Sep ',
          title: 'Date',
        ),
        10.heightBox,
        Content(
          data:
              'Make sure to check your date before making any sort of payments',
          textStyle: context.bodyText.copyWith(
            color: AppColor.baseText,
            height: 1.4,
          ),
          size: 14,
        ),
        10.heightBox,
        Divider(
          thickness: 1,
          color: AppColor.baseText.withValues(alpha: 0.15),
          height: 10,
        ),
      ],
    );
  }
}

class BookingPayment extends StatelessWidget {
  final void Function()? onTap;
  const BookingPayment({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Content(
          data: 'Payments',
          textStyle: context.headingText.copyWith(color: AppColor.primaryText),
          size: 18,
        ),
        15.heightBox,
        IconsCards(
          onTap: onTap,
          prifixIcon: AppAsset.wallet,
          suffixIcon: AppAsset.forward,
          value: 'Credit or Debit card',
        ),
        10.heightBox,
        Divider(
          thickness: 1,
          color: AppColor.baseText.withValues(alpha: 0.15),
          height: 10,
        ),
      ],
    );
  }
}

class BookingPriceSection extends StatelessWidget {
  const BookingPriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Content(
          data: 'Price Details',
          textStyle: context.headingText.copyWith(color: AppColor.primaryText),
          size: 18,
        ),
        15.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Content(data: 'Period time', textStyle: context.bodyText, size: 16),
            Content(data: '1 Month', textStyle: context.headingText, size: 16),
          ],
        ),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Content(
              data: 'Monthly payment',
              textStyle: context.bodyText,
              size: 16,
            ),
            Content(
              data: '\$ 320.00',
              textStyle: context.headingText,
              size: 16,
            ),
          ],
        ),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Content(data: 'Tax', textStyle: context.bodyText, size: 16),
            Content(data: '\$ 10.00', textStyle: context.headingText, size: 16),
          ],
        ),
        10.heightBox,
        Divider(
          thickness: 1,
          color: AppColor.baseText.withValues(alpha: 0.15),
          height: 10,
        ),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Content(data: 'Total', textStyle: context.headingText),
            Content(
              data: '\$ 330.00',
              textStyle: context.titleText.copyWith(
                fontWeight: AppFontWeight.semiBold,
              ),
              size: 24,
            ),
          ],
        ),
      ],
    );
  }
}
