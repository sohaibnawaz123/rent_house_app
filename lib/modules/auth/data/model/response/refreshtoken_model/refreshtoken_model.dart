import 'package:taxi_app/modules/auth/domain/entities/refreshtoken_entity.dart';

class RefreshtokenModel {
  String? userMessage;
  bool? status;

  RefreshtokenModel({
    this.userMessage,
    this.status,
  });

  factory RefreshtokenModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      RefreshtokenModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  RefreshtokenEntity toEntity() {
    return RefreshtokenEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
