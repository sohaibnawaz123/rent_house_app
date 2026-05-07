import 'package:taxi_app/modules/auth/domain/entities/signup_entity.dart';

class SignupModel {
  String? userMessage;
  bool? status;

  SignupModel({
    this.userMessage,
    this.status,
  });

  factory SignupModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      SignupModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  SignupEntity toEntity() {
    return SignupEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
