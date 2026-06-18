import 'package:taxi_app/modules/activity/domain/entities/reserve_entity.dart';

class ReserveModel {
  String? userMessage;
  bool? status;

  ReserveModel({
    this.userMessage,
    this.status,
  });

  factory ReserveModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      ReserveModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  ReserveEntity toEntity() {
    return ReserveEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
