import 'package:taxi_app/modules/auth/domain/entities/login_entity.dart';

class LoginModel {
  String? userMessage;
  bool? status;

  LoginModel({
    this.userMessage,
    this.status,
  });

  factory LoginModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      LoginModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  LoginEntity toEntity() {
    return LoginEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
