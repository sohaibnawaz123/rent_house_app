import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/resource/app_style.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';


class DropDownField extends StatelessWidget {
  final String? hintText, label;
  final double? height, width;
  final List<DropdownMenuItem<dynamic>>? item;
  final void Function(dynamic)? onChanged;
  final List<Widget> Function(BuildContext)? selectedBuilder;
  final dynamic value;

  const DropDownField({
    super.key,
    this.hintText,
    this.label,
    required this.item,
    this.height,
    this.width,
    this.onChanged,
    this.selectedBuilder,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.amber,
      height: height,
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              DropdownButtonFormField2<dynamic>(
                alignment: Alignment.centerLeft,
                value: value,
                isDense: true,
                isExpanded: true,
                style: context.bodyText,
                decoration: InputDecoration(
                  border: AppStyle.inputBorder,
                  focusedBorder: AppStyle.inputBorder,
                  enabledBorder: AppStyle.inputBorder,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 0,
                  ),
                ),
                hint: Text(
                  hintText ?? '',
                  style: context.bodyText.copyWith(
                    color: AppColor.highlight,
                    fontSize: 14.h,
                  ),
                ),
                // iconStyleData: IconStyleData(
                //   icon: SvgPicture.asset(
                //     AppAsset.arrowDownBlk,
                //     theme: SvgTheme(currentColor: AppColor.black),
                //   ),
                //   iconSize: 24,
                // ),
                items: item,
                validator: (value) {
                  if (value == null) {
                    return 'Select Fabric';
                  }
                  return null;
                },
                selectedItemBuilder: selectedBuilder,
                onChanged: onChanged,
                onSaved: (value) {},
                buttonStyleData: ButtonStyleData(padding: EdgeInsets.zero),
                dropdownStyleData: DropdownStyleData(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    boxShadow: [],
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  overlayColor: WidgetStateProperty.all(AppColor.primary),
                  padding: EdgeInsets.symmetric(horizontal: 0),
                ),
              ),
              Positioned(
                top: 0,
                child: Content(
                  data: label ?? "",
                  size: 14.h,
                  textStyle: context.bodyText,
                  color: AppColor.highlight,
                  alignment: TextAlign.start,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
