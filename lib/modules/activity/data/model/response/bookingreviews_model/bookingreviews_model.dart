import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/activity/data/model/response/propertydetail_model/reviewer_model.dart';
import 'package:taxi_app/modules/activity/domain/entities/bookingreviews_entity.dart';

class BookingreviewsModel extends Equatable {
  final int? id;
  final double? rating;
  final String? comment;
  final String? createdAt;
  final String? updatedAt;
  final ReviewerModel? reviewer;

  const BookingreviewsModel({
    this.id,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.reviewer,
  });

  factory BookingreviewsModel.fromJson(Map<String, dynamic> json) {
    return BookingreviewsModel(
      id: json['id'] as int?,
      rating: double.tryParse(json['rating'].toString()),
      comment: json['comment'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      reviewer: json['reviewer'] != null
          ? ReviewerModel.fromJson(json['reviewer'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'reviewer': reviewer?.toJson(),
    };
  }

  BookingreviewsModel copyWith({
    int? id,
    double? rating,
    String? comment,
    String? createdAt,
    String? updatedAt,
    ReviewerModel? reviewer,
  }) {
    return BookingreviewsModel(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reviewer: reviewer ?? this.reviewer,
    );
  }

  BookingreviewsEntity toEntity() {
    return BookingreviewsEntity(
      id: id ?? 0,
      rating: rating ?? 0,
      comment: comment ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      reviewer: reviewer?.toEntity(),
    );
  }

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
