import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_color.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final double? width;
  final double? height;
  const Pagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? (width ?? 12) : ((width! / 2) ?? 6),
          height: isActive ? (height ?? 6) : (height ?? 6),
          decoration: BoxDecoration(
            color: isActive ? AppColor.primary : AppColor.highlight,
            borderRadius: BorderRadius.circular(6),
          ),
        );
      }),
    );
  }
}
