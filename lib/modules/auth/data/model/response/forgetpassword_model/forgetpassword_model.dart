import 'package:taxi_app/modules/auth/domain/entities/forgetpassword_entity.dart';

class ForgetpasswordModel {
  String? userMessage;
  bool? status;

  ForgetpasswordModel({
    this.userMessage,
    this.status,
  });

  factory ForgetpasswordModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      ForgetpasswordModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  ForgetpasswordEntity toEntity() {
    return ForgetpasswordEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
