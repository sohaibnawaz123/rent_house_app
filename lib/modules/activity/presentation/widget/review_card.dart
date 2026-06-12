import 'package:flutter/material.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/activity/presentation/widget/rating_stare.dart';

class PropertyReviewEntity {
  final String name;
  final String review;
  final double rateing;

  PropertyReviewEntity({
    required this.name,
    required this.review,
    required this.rateing,
  });
}

class ReviewCard extends StatelessWidget {
  final PropertyReviewEntity reviews;
  const ReviewCard({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.82,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColor.black.withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColor.highlight,
              child: Content(
                data: reviews.name[0],
                size: 16,
                textStyle: context.headingText.copyWith(),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Content(data: reviews.name)),
                      RatingStars(rating: reviews.rateing),
                    ],
                  ),
                  Content(
                    data: reviews.review,
                    textStyle: context.bodyText.copyWith(),
                    size: 14,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
