import 'package:taxi_app/modules/auth/domain/entities/register_entity.dart';

class RegisterModel {
  String? userMessage;
  bool? status;

  RegisterModel({
    this.userMessage,
    this.status,
  });

  factory RegisterModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      RegisterModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  RegisterEntity toEntity() {
    return RegisterEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
