import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/custom_tab.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/payment/payment_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/paymentcard/paymentcard_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/routes/paymentcard_view_initial_params.dart';
import 'package:taxi_app/modules/setting/presentation/views/paymentcard_view.dart';
import 'package:taxi_app/modules/setting/presentation/widgets/card_widget.dart';

class PaymentView extends StatefulWidget {
  final PaymentBloc bloc;
  const PaymentView({super.key, required this.bloc});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  int selected = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> data = ["transcation", "Cards"];
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.base,

      body: ListView(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          context.pagePadding.top,
          context.pagePadding.left,
          context.pagePadding.bottom,
          // 0,
        ),
        children: [
          HeaderWidget(title: "Payments"),
          20.heightBox,
          CardList(),
          // Container(
          //   padding: EdgeInsets.all(5),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8),
          //     color: AppColor.baseText.withValues(alpha: 0.25),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     spacing: 10,
          //     children: List.generate(data.length, (index) {
          //       return CustomBookingTab(
          //         onTap: () {
          //           setState(() {
          //             selected = index;
          //           });
          //         },
          //         data: data[index],
          //         isSelected: selected == index,
          //       );
          //     }),
          //   ),
          // ),
          // 20.heightBox,

          // if (selected == 0) ...[Transcations()] else ...[Cards()],
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
          title: 'Add New Card',
          onTap: () => context.pushPage(
            PaymentcardView(
              bloc: getIt<PaymentcardBloc>(
                param1: PaymentcardViewInitialParams(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  const CardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CardWidget();
      },
      separatorBuilder: (context, index) {
        return 10.heightBox;
      },
      itemCount: 5,
    );
  }
}
