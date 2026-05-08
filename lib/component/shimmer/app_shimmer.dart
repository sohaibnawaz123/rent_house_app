import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_color.dart';

class AppShimmer extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry borderRadius;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry margin;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;

  const AppShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.shape,
    this.margin = EdgeInsets.zero,
    this.baseColor = AppColor.grey,
    this.highlightColor = AppColor.highlight,
    this.duration = const Duration(milliseconds: 1400),
  });

  const AppShimmer.image({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.margin = EdgeInsets.zero,
    this.baseColor = AppColor.grey,
    this.highlightColor = AppColor.highlight,
    this.duration = const Duration(milliseconds: 1400),
  }) : shape = null;

  const AppShimmer.card({
    super.key,
    this.width = double.infinity,
    this.height = 120,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.margin = EdgeInsets.zero,
    this.baseColor = AppColor.grey,
    this.highlightColor = AppColor.highlight,
    this.duration = const Duration(milliseconds: 1400),
  }) : shape = null;

  const AppShimmer.text({
    super.key,
    this.width = double.infinity,
    this.height = 14,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.margin = EdgeInsets.zero,
    this.baseColor = AppColor.grey,
    this.highlightColor = AppColor.highlight,
    this.duration = const Duration(milliseconds: 1400),
  }) : shape = null;

  const AppShimmer.circle({
    super.key,
    double size = 48,
    this.margin = EdgeInsets.zero,
    this.baseColor = AppColor.grey,
    this.highlightColor = AppColor.highlight,
    this.duration = const Duration(milliseconds: 1400),
  })  : width = size,
        height = size,
        borderRadius = BorderRadius.zero,
        shape = const CircleBorder();

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void didUpdateWidget(covariant AppShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final slide = _controller.value * 2 - 1;

            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.25, 0.5, 0.75],
              transform: _SlidingGradientTransform(slide),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        decoration: ShapeDecoration(
          color: widget.baseColor,
          shape:
              widget.shape ??
              RoundedRectangleBorder(borderRadius: widget.borderRadius),
        ),
      ),
    );
  }
}

class AppShimmerCard extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double imageHeight;
  final bool showImage;
  final bool showAvatar;
  final int textLines;

  const AppShimmerCard({
    super.key,
    this.padding = const EdgeInsets.all(12),
    this.margin = EdgeInsets.zero,
    this.imageHeight = 140,
    this.showImage = true,
    this.showAvatar = false,
    this.textLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showImage) ...[
            AppShimmer.image(height: imageHeight),
            const SizedBox(height: 12),
          ],
          if (showAvatar) ...[
            const Row(
              children: [
                AppShimmer.circle(size: 44),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmer.text(width: 140),
                      SizedBox(height: 8),
                      AppShimmer.text(width: 90, height: 12),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          ...List.generate(
            textLines,
            (index) => AppShimmer.text(
              width: index == textLines - 1 ? 180 : double.infinity,
              margin: EdgeInsets.only(bottom: index == textLines - 1 ? 0 : 8),
            ),
          ),
        ],
      ),
    );
  }
}

class AppShimmerListTile extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool showTrailing;

  const AppShimmerListTile({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.margin = EdgeInsets.zero,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            const AppShimmer.circle(size: 48),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmer.text(width: double.infinity),
                  SizedBox(height: 8),
                  AppShimmer.text(width: 140, height: 12),
                ],
              ),
            ),
            if (showTrailing) ...[
              const SizedBox(width: 12),
              const AppShimmer(width: 42, height: 24),
            ],
          ],
        ),
      ),
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double percent;

  const _SlidingGradientTransform(this.percent);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * percent, 0, 0);
  }
}
