import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/resource/app_color.dart';

enum _AppImageType { auto, network, asset, svg, file }

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
    return _clipImage(
      shape: shape,
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: size,
        width: size,
        fit: fit,
        placeholder: (context, url) => Skeleton.leaf(
          child: _imageContainer(color: errorBgColor, shape: shape, size: size),
        ),
        errorWidget: (context, error, stackTrace) {
          return placeholder ?? _errorImage();
        },
      ),
    );
  }

  Widget _errorImage() {
    if (defaultImage != null) {
      return Image.asset(defaultImage!, height: size, width: size, fit: fit);
    }

    return _imageContainer(
      color: errorBgColor,
      shape: shape,
      size: size,
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Icon(Icons.error, color: AppColor.white),
      ),
    );
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
  final Color? svgColor;
  final bool useBaseUrl;
  final _AppImageType _type;

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
    this.svgColor,
    this.useBaseUrl = true,
  }) : _type = _AppImageType.auto;

  factory AppImage.network({
    Key? key,
    required String imageUrl,
    double size = 38.0,
    BoxFit fit = BoxFit.cover,
    ShapeBorder shape = const CircleBorder(),
    double? borderRadius,
    String? defaultImage,
    Widget? placeholder,
    Color? errorBgColor = AppColor.highlightText,
    bool useBaseUrl = false,
  }) {
    return AppImage._(
      key: key,
      imageUrl: imageUrl,
      size: size,
      fit: fit,
      shape: shape,
      borderRadius: borderRadius,
      defaultImage: defaultImage,
      placeholder: placeholder,
      errorBgColor: errorBgColor,
      useBaseUrl: useBaseUrl,
      type: _AppImageType.network,
    );
  }

  factory AppImage.asset({
    Key? key,
    required String assetPath,
    double size = 38.0,
    BoxFit fit = BoxFit.cover,
    ShapeBorder shape = const CircleBorder(),
    double? borderRadius,
    String? defaultImage,
    Widget? placeholder,
    Color? errorBgColor = AppColor.highlightText,
  }) {
    return AppImage._(
      key: key,
      imageUrl: assetPath,
      size: size,
      fit: fit,
      shape: shape,
      borderRadius: borderRadius,
      defaultImage: defaultImage,
      placeholder: placeholder,
      errorBgColor: errorBgColor,
      useBaseUrl: false,
      type: _AppImageType.asset,
    );
  }

  factory AppImage.svg({
    Key? key,
    required String svgPath,
    double size = 38.0,
    BoxFit fit = BoxFit.contain,
    ShapeBorder shape = const CircleBorder(),
    double? borderRadius,
    String? defaultImage,
    Widget? placeholder,
    Color? errorBgColor = AppColor.highlightText,
    Color? svgColor,
  }) {
    return AppImage._(
      key: key,
      imageUrl: svgPath,
      size: size,
      fit: fit,
      shape: shape,
      borderRadius: borderRadius,
      defaultImage: defaultImage,
      placeholder: placeholder,
      errorBgColor: errorBgColor,
      svgColor: svgColor,
      useBaseUrl: false,
      type: _AppImageType.svg,
    );
  }

  factory AppImage.file({
    Key? key,
    required String filePath,
    double size = 38.0,
    BoxFit fit = BoxFit.cover,
    ShapeBorder shape = const CircleBorder(),
    double? borderRadius,
    String? defaultImage,
    Widget? placeholder,
    Color? errorBgColor = AppColor.highlightText,
  }) {
    return AppImage._(
      key: key,
      localImage: filePath,
      size: size,
      fit: fit,
      shape: shape,
      borderRadius: borderRadius,
      defaultImage: defaultImage,
      placeholder: placeholder,
      errorBgColor: errorBgColor,
      useBaseUrl: false,
      type: _AppImageType.file,
    );
  }

  const AppImage._({
    super.key,
    this.imageUrl = '',
    this.localImage = '',
    this.size = 38.0,
    this.fit = BoxFit.cover,
    this.shape = const CircleBorder(),
    this.borderRadius,
    this.defaultImage,
    this.placeholder,
    this.errorBgColor = AppColor.highlightText,
    this.svgColor,
    this.useBaseUrl = true,
    required _AppImageType type,
  }) : _type = type;

  @override
  Widget build(BuildContext context) {
    return _clipImage(
      shape: shape,
      borderRadius: borderRadius,
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    final type = _resolvedType;

    if (type == _AppImageType.file) {
      return Image.file(
        File(localImage),
        height: size.h,
        width: size.h,
        fit: fit,
      );
    }

    if (type == _AppImageType.asset) {
      return Image.asset(
        imageUrl,
        height: size.h,
        width: size.h,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _errorImage(),
      );
    }

    if (type == _AppImageType.svg) {
      return SvgPicture.asset(
        imageUrl,
        height: size.h,
        width: size.h,
        fit: fit,
        colorFilter: svgColor == null
            ? null
            : ColorFilter.mode(svgColor!, BlendMode.srcIn),
        placeholderBuilder: (context) =>
            placeholder ??
            _imageContainer(color: errorBgColor, shape: shape, size: size.h),
      );
    }

    return AppNetworkImage(
      imageUrl: _networkUrl,
      size: size.h,
      fit: fit,
      shape: shape,
      borderRadius: borderRadius,
      defaultImage: defaultImage,
      placeholder: placeholder,
      errorBgColor: errorBgColor,
    );
  }

  _AppImageType get _resolvedType {
    if (_type != _AppImageType.auto) return _type;
    if (localImage.isNotEmpty) return _AppImageType.file;
    if (_isSvg(imageUrl)) return _AppImageType.svg;
    if (_isAssetPath(imageUrl)) return _AppImageType.asset;
    return _AppImageType.network;
  }

  String get _networkUrl {
    if (!useBaseUrl || imageUrl.startsWith('http')) return imageUrl;
    return AppUrl.baseUrl + imageUrl;
  }

  Widget _errorImage() {
    return placeholder ??
        _imageContainer(
          color: errorBgColor,
          shape: shape,
          size: size.h,
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.error, color: AppColor.white),
          ),
        );
  }
}

bool _isSvg(String path) => path.toLowerCase().endsWith('.svg');

bool _isAssetPath(String path) {
  return path.startsWith('assets/') ||
      path.toLowerCase().endsWith('.png') ||
      path.toLowerCase().endsWith('.jpg') ||
      path.toLowerCase().endsWith('.jpeg') ||
      path.toLowerCase().endsWith('.webp');
}

Widget _imageContainer({
  required Color? color,
  required ShapeBorder shape,
  required double size,
  Widget? child,
}) {
  return Container(
    height: size,
    width: size,
    decoration: ShapeDecoration(color: color, shape: shape),
    child: child,
  );
}

Widget _clipImage({
  required ShapeBorder shape,
  required double? borderRadius,
  required Widget child,
}) {
  if (shape is RoundedRectangleBorder) {
    final borderRadiusValue =
        borderRadius ??
        shape.borderRadius.resolve(TextDirection.ltr).topLeft.x;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadiusValue),
      child: child,
    );
  }

  if (shape is CircleBorder) {
    return ClipOval(child: child);
  }

  return child;
}
