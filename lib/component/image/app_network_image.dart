import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';


class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  final BoxFit fit;
  final Color? errorBgColor;
  final ShapeBorder shape;
  final double? borderRadius;
  final String? defaultImage;
  final Widget? placeholder;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.size = 38.0,
    this.fit = BoxFit.cover,
    this.errorBgColor = AppColor.highlight,
    this.shape = const CircleBorder(),
    this.borderRadius,
    this.defaultImage,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      height: size,
      width: size,
      fit: fit,
      placeholder: (context, url) => Skeleton.leaf(
        child: Container(
          height: size,
          width: size,
          decoration: ShapeDecoration(color: errorBgColor, shape: shape),
        ),
      ),
      errorWidget: (context, error, stackTrace) {
        return placeholder ??
            Container(
              height: size,
              width: size,
              decoration: ShapeDecoration(color: errorBgColor, shape: shape),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(  
                  Icons.error,
                  color: AppColor.white,
                ),
              ),
            );
      },
    );

    if (shape is RoundedRectangleBorder) {
      final borderRadiusValue =
          borderRadius ??
          (shape as RoundedRectangleBorder).borderRadius
              .resolve(TextDirection.ltr)
              .topLeft
              .x;
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadiusValue),
        child: image,
      );
    } else if (shape is CircleBorder) {
      return ClipOval(child: image);
    } else {
      return image;
    }
  }
}

class AppImage extends StatelessWidget {
  final String imageUrl;
  final String localImage;
  final double size;
  final BoxFit fit;
  final ShapeBorder shape;
  final double? borderRadius;
  final String? defaultImage;
  final Widget? placeholder;
  final Color? errorBgColor;

  const AppImage({
    super.key,
    required this.imageUrl,
    this.localImage = '',
    this.size = 38.0,
    this.fit = BoxFit.cover,
    this.shape = const CircleBorder(),
    this.borderRadius,
    this.defaultImage,
    this.placeholder,
    this.errorBgColor = AppColor.highlightText,
  });

  @override
  Widget build(BuildContext context) {
    final String fullImageUrl = AppUrl.baseUrl + imageUrl;

    Widget imageWidget;

    if (localImage != '') {
      imageWidget = Image.file(
        File(localImage),
        height: size.h,
        width: size.h,
        fit: fit,
      );
    } else {
      imageWidget = AppNetworkImage(
        imageUrl: fullImageUrl,
        size: size.h,
        fit: fit,
        shape: shape,
        borderRadius: borderRadius,
        defaultImage: defaultImage,
        placeholder: placeholder,
        errorBgColor: errorBgColor,
      );
    }

    if (shape is RoundedRectangleBorder) {
      final borderRadiusValue =
          borderRadius ??
          (shape as RoundedRectangleBorder).borderRadius
              .resolve(TextDirection.ltr)
              .topLeft
              .x;
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadiusValue),
        child: imageWidget,
      );
    } else if (shape is CircleBorder) {
      return ClipOval(child: imageWidget);
    } else {
      return imageWidget;
    }
  }
}
