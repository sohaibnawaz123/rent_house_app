import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_padding.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';

class LabelTextField extends StatefulWidget {
  const LabelTextField({
    super.key,
    this.controller,
    this.enabled = true,
    this.initialValue,
    this.obscureText = false,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.labelText = 'Text Form',
    this.helperText,
    this.errorText,
    this.hintText = 'Input Text Here',
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.onTapOutside,
    this.maxLines = 1,
    this.minLines,
    this.contentPadding,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.helperStyle,
    this.errorStyle,
    this.radius = 10,
    this.isSuccess = false,
    this.fillColor,
    this.successColor = AppColor.success,
    this.errorColor = AppColor.errorText,
    this.focusedColor = AppColor.primary,
    this.borderColor = const Color(0xFFD0D5DD),
    this.disabledColor = AppColor.disabledText,
    this.iconColor,
  });

  final TextEditingController? controller;
  final bool enabled;
  final String? initialValue;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final String labelText;
  final String? helperText;
  final String? errorText;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Function(PointerDownEvent)? onTapOutside;
  final int? maxLines;
  final int? minLines;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final double radius;
  final bool isSuccess;
  final Color? fillColor;
  final Color successColor;
  final Color errorColor;
  final Color focusedColor;
  final Color borderColor;
  final Color disabledColor;
  final Color? iconColor;

  @override
  State<LabelTextField> createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
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
    final hasError = widget.errorText != null;
    final helperText = widget.errorText ?? widget.helperText;
    final helperColor = hasError
        ? widget.errorColor
        : widget.isSuccess
        ? widget.successColor
        : AppColor.baseText;
    final iconColor = widget.iconColor ?? _iconColor(hasError);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Content(
          data: widget.labelText,
          textStyle:
              widget.labelStyle ??
              context.lableText.copyWith(
                color: AppColor.primaryText,
                // fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          cursorHeight: 20,
          keyboardAppearance: Brightness.light,
          obscuringCharacter: '*',
          enabled: widget.enabled,
          initialValue: widget.initialValue,
          obscureText: _obscureText,
          inputFormatters: widget.inputFormatters,
          onTapOutside:
              widget.onTapOutside ??
              (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          onChanged: widget.onChanged,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator,
          style:
              widget.textStyle ??
              context.bodyText.copyWith(
                fontSize: 16.sp,
                color: widget.enabled
                    ? AppColor.primaryText
                    : AppColor.baseText,
              ),
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor ?? _fillColor,
            hintText: widget.hintText,
            hintStyle:
                widget.hintStyle ??
                context.bodyText.copyWith(
                  color: AppColor.baseText,
                  fontSize: 14.sp,
                ),
            isDense: true,
            contentPadding:
                widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? _buildPasswordIcon(iconColor)
                : widget.suffixIcon,
            prefixIconConstraints: BoxConstraints(
              minWidth: 44.w,
              minHeight: 24.h,
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: 44.w,
              minHeight: 24.h,
            ),
            border: _outlineBorder(widget.borderColor),
            enabledBorder: _outlineBorder(
              widget.isSuccess ? widget.successColor : widget.borderColor,
            ),
            focusedBorder: _outlineBorder(
              widget.isSuccess ? widget.successColor : widget.focusedColor,
            ),
            disabledBorder: _outlineBorder(widget.borderColor),
            errorBorder: _outlineBorder(widget.errorColor),
            focusedErrorBorder: _outlineBorder(widget.errorColor),
            errorText: widget.errorText,
            errorStyle: const TextStyle(height: 0, fontSize: 0),
          ),
        ),
        if (helperText != null) ...[
          SizedBox(height: 6.h),
          Content(
            data: helperText,
            textStyle:
                (hasError ? widget.errorStyle : widget.helperStyle) ??
                context.lightText.copyWith(color: helperColor, fontSize: 12.sp),
          ),
        ],
      ],
    );
  }

  Color get _fillColor {
    if (!widget.enabled) return widget.disabledColor;
    if (widget.isSuccess) return widget.successColor.withValues(alpha: 0.10);
    return AppColor.white;
  }

  Color _iconColor(bool hasError) {
    if (hasError) return AppColor.primaryText;
    if (!widget.enabled) return AppColor.baseText;
    return AppColor.baseText;
  }

  OutlineInputBorder _outlineBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.radius.r),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  // Widget _buildDefaultIcon(Color color) {
  //   return SvgPicture.asset(
  //     AppAsset.eyeoff,
  //     height: 20.h,
  //     width: 20.w,
  //     fit: BoxFit.scaleDown,
  //     theme: SvgTheme(currentColor: color),
  //     colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  //   ).paddingAll(12.h);
  // }

  Widget _buildPasswordIcon(Color color) {
    return GestureDetector(
      onTap: _toggleObscure,
      child: SvgPicture.asset(
        _obscureText ? AppAsset.eye : AppAsset.eyeoff,
        height: 24.h,
        width: 24.w,
        fit: BoxFit.scaleDown,
        theme: SvgTheme(currentColor: color),
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ).paddingAll(12.h),
    );
  }
}
