import 'package:taxi_app/modules/auth/domain/entities/otpverification_entity.dart';

class OtpverificationModel {
  String? userMessage;
  bool? status;

  OtpverificationModel({
    this.userMessage,
    this.status,
  });

  factory OtpverificationModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      OtpverificationModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  OtpverificationEntity toEntity() {
    return OtpverificationEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
