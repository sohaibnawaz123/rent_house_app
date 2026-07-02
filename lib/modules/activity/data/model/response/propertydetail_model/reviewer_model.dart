import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/activity/domain/entities/reviewer_entity.dart';

class ReviewerModel extends Equatable {
  final int? id;
  final String? username;
  final String? email;

  const ReviewerModel({this.id, this.username, this.email});

  factory ReviewerModel.fromJson(Map<String, dynamic> json) {
    return ReviewerModel(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'email': email};
  }

  ReviewerModel copyWith({int? id, String? username, String? email}) {
    return ReviewerModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  ReviewerEntity toEntity() {
    return ReviewerEntity(
      id: id ?? 0,
      username: username ?? '',
      email: email ?? '',
    );
  }

  @override
  List<Object?> get props => [id, username, email];
}
