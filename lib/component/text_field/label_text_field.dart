// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
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
    this.validateWhileTyping = true,
    this.resetValidationOnUnfocus = true,
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
  final bool validateWhileTyping;
  final bool resetValidationOnUnfocus;

  @override
  State<LabelTextField> createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
  late bool _obscureText;
  late FocusNode _focusNode;
  bool _hasFocus = false;
  bool _isFilled = false;
  bool _hasInteracted = false;
  String? _liveErrorText;
  String? _formErrorText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
    if (widget.controller != null) {
      _isFilled = widget.controller!.text.isNotEmpty;
      widget.controller!.addListener(_handleTextChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.controller != null) {
      widget.controller!.removeListener(_handleTextChange);
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
      if (_hasFocus && _isFilled) {
        _validateText(_currentText);
      } else if (widget.resetValidationOnUnfocus) {
        _hasInteracted = false;
        _liveErrorText = null;
      }
    });
  }

  void _handleTextChange() {
    setState(() {
      _isFilled = widget.controller!.text.isNotEmpty;
      if (widget.validateWhileTyping) {
        _validateText(widget.controller!.text);
      }
    });
  }

  String get _currentText {
    if (widget.controller != null) return widget.controller!.text;
    return widget.initialValue ?? '';
  }

  void _validateText(String value) {
    if (!_hasFocus || widget.validator == null) return;
    _hasInteracted = true;
    _liveErrorText = widget.validator!(value);
    _formErrorText = null;
  }

  String? _validateFormField(String? value) {
    final errorText = widget.validator?.call(value);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _formErrorText == errorText) return;
      setState(() {
        _formErrorText = errorText;
      });
    });
    return errorText;
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = !widget.enabled;
    final isTyping = _hasFocus;
    final isFilled = _isFilled;
    final liveValidationIsVisible =
        widget.validateWhileTyping &&
        isTyping &&
        _hasInteracted &&
        widget.validator != null;
    final effectiveErrorText = liveValidationIsVisible
        ? _liveErrorText
        : widget.errorText ?? _formErrorText;
    final hasError = effectiveErrorText != null;
    final isSuccess =
        !hasError &&
        !isDisabled &&
        ((liveValidationIsVisible && isFilled) || widget.isSuccess);

    // Border color logic
    Color borderColor = widget.borderColor;
    if (isDisabled) {
      borderColor = widget.disabledColor;
    } else if (hasError) {
      borderColor = widget.errorColor;
    } else if (isSuccess) {
      borderColor = widget.successColor;
    } else if (isTyping) {
      borderColor = widget.focusedColor;
    }

    // Helper text and color logic
    String? helperText = effectiveErrorText ?? widget.helperText;
    Color helperColor = AppColor.baseText;
    if (hasError) {
      helperColor = widget.errorColor;
    } else if (isSuccess) {
      helperColor = widget.successColor;
    } else if (isDisabled) {
      helperColor = widget.disabledColor;
    }

    // Fill color logic
    Color fillColor = AppColor.white;
    if (isDisabled) {
      fillColor = widget.disabledColor;
    } else if (isSuccess) {
      fillColor = widget.successColor.withOpacity(0.10);
    }

    // Icon color logic
    Color iconColor =
        widget.iconColor ??
        _iconColor(hasError, isDisabled, isSuccess, isTyping);

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
                fontWeight: AppFontWeight.semiBold,
              ),
              size: 14,
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
          onChanged: (value) {
            if (widget.validateWhileTyping && widget.controller == null) {
              setState(() {
                _isFilled = value.isNotEmpty;
                _validateText(value);
              });
            }
            widget.onChanged?.call(value);
          },
          focusNode: _focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator == null ? null : _validateFormField,
          autovalidateMode: widget.validateWhileTyping
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
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
            fillColor: widget.fillColor ?? fillColor,
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
            enabledBorder: _outlineBorder(borderColor),
            focusedBorder: _outlineBorder(borderColor),
            disabledBorder: _outlineBorder(widget.disabledColor),
            errorBorder: _outlineBorder(widget.errorColor),
            focusedErrorBorder: _outlineBorder(widget.errorColor),
            errorText: effectiveErrorText,
            errorStyle: const TextStyle(height: 0, fontSize: 0),
          ),
        ),
        if (helperText != null) ...[
          SizedBox(height: 4.h),
          Content(
            data: helperText,
            textStyle:
                (hasError ? widget.errorStyle : widget.helperStyle) ??
                context.errorText.copyWith(color: helperColor, fontSize: 12),
            size: 12,
          ),
        ],
      ],
    );
  }

  Color _iconColor(
    bool hasError,
    bool isDisabled,
    bool isSuccess,
    bool isTyping,
  ) {
    if (hasError) return AppColor.primaryText;
    if (isDisabled) return AppColor.baseText;
    if (isSuccess) return widget.successColor;
    if (isTyping) return widget.focusedColor;
    return AppColor.baseText;
  }

  OutlineInputBorder _outlineBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.radius.r),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

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
