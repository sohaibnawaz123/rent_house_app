import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating; // e.g. 4.5
  final int maxStars;
  final double size;
  final Color filledColor;
  final Color emptyColor;

  const RatingStars({
    super.key,
    required this.rating,
    this.maxStars = 5,
    this.size = 20,
    this.filledColor = Colors.orange,
    this.emptyColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: filledColor, size: size);
        } else if (index < rating && rating % 1 != 0) {
          return Icon(Icons.star_half, color: filledColor, size: size);
        } else {
          return Icon(Icons.star_border, color: emptyColor, size: size);
        }
      }),
    );
  }
}
