

import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/activity/domain/entities/reviewer_entity.dart';

class BookingreviewsEntity extends Equatable {
  final int id;
  final double rating;
  final String comment;
  final String createdAt;
  final String updatedAt;
  final ReviewerEntity? reviewer;

  const BookingreviewsEntity({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    this.reviewer,
  });

  @override
  List<Object?> get props => [
    id,
    rating,
    comment,
    createdAt,
    updatedAt,
    reviewer,
  ];
}
