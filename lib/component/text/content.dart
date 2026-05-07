import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Content extends StatelessWidget {
  String data;
  double size;
  Color? color, decorationColor;
  int? maxLines;
  FontWeight? weight;
  TextAlign? alignment;
  TextDecoration? decoration;
  TextStyle? textStyle;
  TextOverflow? overflow;

  Content({
    super.key,
    required this.data,
    this.size = 16,
    this.color,
    this.decorationColor,
    this.maxLines,
    this.decoration,
    this.weight,
    this.alignment,
    this.textStyle,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: alignment,
      maxLines: maxLines ?? 100,
      softWrap: true,
      overflow: overflow,
      style:
          textStyle?.copyWith(
            color: color,
            fontWeight: weight,
            decoration: decoration,
            fontSize: size.h,
          ) ??
          TextStyle(
            decoration: decoration,
            decorationColor: decorationColor,
            fontSize: size.h,
            color: color,
            fontWeight: weight,

            overflow: TextOverflow.ellipsis,
          ),
    );
  }
}
