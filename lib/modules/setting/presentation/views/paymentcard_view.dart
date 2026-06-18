import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/component/text_field/label_text_field.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/paymentcard/paymentcard_bloc.dart';

class PaymentcardView extends StatefulWidget {
  final PaymentcardBloc bloc;
  const PaymentcardView({super.key, required this.bloc});

  @override
  State<PaymentcardView> createState() => _PaymentcardViewState();
}

class _PaymentcardViewState extends State<PaymentcardView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.base,
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          context.pagePadding.top,
          context.pagePadding.right,
          context.pagePadding.bottom,
        ),
        children: [
          HeaderWidget(title: "Add Card"),
          50.heightBox,
          CardDesign(),
          50.heightBox,
          FeildsSection(),
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
          title: 'Add Card',
          
        ),
      ),
    );
  }
}

class FeildsSection extends StatelessWidget {
  const FeildsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: [
        LabelTextField(labelText: 'Name', hintText: 'Brooklyn Simmons'),
        LabelTextField(
          labelText: 'Card Number',
          hintText: '4242 4242 4242 4242',
        ),
        Row(
          spacing: 20,
          children: [
            Expanded(
              child: LabelTextField(labelText: 'Expired', hintText: '07/12'),
            ),
            Expanded(
              child: LabelTextField(labelText: 'CvC', hintText: '123'),
            ),
          ],
        ),
      ],
    );
  }
}

class CardDesign extends StatelessWidget {
  const CardDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Color(0xff832388), Color(0xff932883), Color(0xffA32E7E)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.45),
            offset: Offset(0, 10),
            blurRadius: 15,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            //right circle
            Positioned(
              top: -100,
              right: -30,
              child: _circle(
                colors: [],
                radius: 100,
                color: AppColor.white.withValues(alpha: 0.2),
              ),
            ),
            //bottom circle
            Positioned(
              bottom: -170,
              left: -10,
              child: _circle(
                colors: [
                  // AppColor.white.withValues(alpha: 0.25),
                  AppColor.white.withValues(alpha: 0.35),
                  AppColor.transparent,
                ],
                radius: 170,
                isGradient: true,
                color: AppColor.white.withValues(alpha: 0.5),
              ),
            ),

            //logo
            Positioned(
              top: 20,
              right: 20,
              child: _circle(radius: 10, color: Color(0xffF79E1B), colors: []),
            ),
            Positioned(
              top: 20,
              right: 30,
              child: _circle(
                radius: 10,
                color: Color(0xffEB001B).withValues(alpha: 0.7),
                colors: [],
              ),
            ),

            // card Name
            Positioned(
              top: 20,
              left: 20,
              child: Content(
                data: 'Credit Card',
                textStyle: context.bodyText.copyWith(color: AppColor.white),
              ),
            ),
            Positioned(
              top: 100,
              left: 20,
              child: Content(
                data: '1234 1234 1234 1234',
                textStyle: context.bodyText.copyWith(color: AppColor.white),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Content(
                data: 'Brooklynsim',
                textStyle: context.bodyText.copyWith(color: AppColor.white),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Content(
                data: '07/26',
                textStyle: context.bodyText.copyWith(color: AppColor.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle({
    required double radius,
    bool isGradient = false,
    required Color color,
    required List<Color> colors,
  }) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isGradient ? null : color,
        gradient: isGradient
            ? LinearGradient(
                colors: colors,
                begin: Alignment(-1, -1),
                end: Alignment(0.25, 0.25),
              )
            : null,
      ),
    );
  }
}
