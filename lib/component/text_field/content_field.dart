import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/resource/app_style.dart';
import 'package:taxi_app/core/utils/extension/app_padding.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

class ContentField extends StatefulWidget {
  const ContentField({
    super.key,
    this.controller,
    this.enabled = true,
    this.initialValue,
    this.obscureText = false,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.filled = true,
    this.fillColor = AppColor.transparent,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixText,
    this.prefixStyle,
    this.suffixIconColor,
    this.suffixIconSize,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.error,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.disabledBorder,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.isDense = true,
    this.readOnly = false,
    this.alignLabelWithText,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.border,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 10,
    ),
    this.contentStyle,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.onTapOutside,
  });

  final TextEditingController? controller;
  final bool enabled;
  final String? initialValue;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool filled;
  final Color fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final BoxConstraints? suffixIconConstraints, prefixIconConstraints;
  final Widget? error;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final bool isDense;
  final bool readOnly;
  final bool? alignLabelWithText;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final InputBorder? border;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? contentStyle;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Function(PointerDownEvent)? onTapOutside;

  @override
  State<ContentField> createState() => _ContentFieldState();
}

class _ContentFieldState extends State<ContentField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.obscureText;
    return TextFormField(
      obscuringCharacter: '*',

      onTapOutside:
          widget.onTapOutside ??
          (_) => FocusManager.instance.primaryFocus?.unfocus(),
      enabled: widget.enabled,
      initialValue: widget.initialValue,
      obscureText: _obscureText,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        filled: widget.filled,
        fillColor: widget.fillColor,
        border: widget.border,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        enabledBorder: widget.enabledBorder ?? AppStyle.inputBorder,
        focusedBorder: widget.focusedBorder ?? AppStyle.inputBorder,
        errorBorder: widget.errorBorder ?? AppStyle.errorInputBorder,
        focusedErrorBorder:
            widget.focusedErrorBorder ?? AppStyle.errorInputBorder,
        error: widget.error,
        hintText: widget.hintText,
        hintStyle:
            widget.hintStyle ??
            context.bodyText.copyWith(
              color: AppColor.highlight,
              fontSize: 12.h,
            ),
        isDense: widget.isDense,
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: _toggleObscure,
                child: SvgPicture.asset(
                  _obscureText ? AppAsset.eye : AppAsset.eyeoff,
                  theme: SvgTheme(currentColor: AppColor.black),
                ).paddingAll(14.h),
              )
            : widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        prefixText: widget.prefixText,
        prefixStyle: widget.prefixStyle ?? context.bodyText,
        prefixIconConstraints: widget.prefixIconConstraints,
        contentPadding: widget.contentPadding,
        suffixIconConstraints: widget.suffixIconConstraints,
        labelText: widget.labelText,
        labelStyle:
            widget.labelStyle ??
            context.bodyText.copyWith(
              color: AppColor.highlight,
              fontSize: 18.h,
            ),
        alignLabelWithHint: widget.alignLabelWithText,
      ),
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      validator: widget.validator,
      style:
          widget.contentStyle ??
          context.bodyText.copyWith(fontSize: 16.h, color: AppColor.black),
      maxLines: widget.maxLines,
      minLines: widget.minLines,
    );
  }
}
