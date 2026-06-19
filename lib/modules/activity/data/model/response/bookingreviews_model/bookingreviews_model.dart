import 'package:taxi_app/modules/activity/domain/entities/bookingreviews_entity.dart';

class BookingreviewsModel {
  String? userMessage;
  bool? status;

  BookingreviewsModel({
    this.userMessage,
    this.status,
  });

  factory BookingreviewsModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      BookingreviewsModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  BookingreviewsEntity toEntity() {
    return BookingreviewsEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
