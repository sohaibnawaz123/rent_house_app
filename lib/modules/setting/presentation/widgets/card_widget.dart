import 'package:flutter/material.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.highlight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          CircleAvatar(radius: 24, backgroundColor: AppColor.white),
          Expanded(
            // fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Content(
                  data: '**** **** **** 4242',
                  textStyle: context.bodyText.copyWith(color: AppColor.black,fontWeight: AppFontWeight.semiBold),
                  size: 16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Content(
                  data: '12/26',
                  textStyle: context.bodyText.copyWith(color: AppColor.black),
                  size: 14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColor.white,
            child: Icon(Icons.more_vert_rounded, color: AppColor.btnBg),
          ),
        ],
      ),
    );
  }
}
