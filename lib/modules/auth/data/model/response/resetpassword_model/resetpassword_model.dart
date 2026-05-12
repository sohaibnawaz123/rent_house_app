import 'package:taxi_app/modules/auth/domain/entities/resetpassword_entity.dart';

class ResetpasswordModel {
  String? userMessage;
  bool? status;

  ResetpasswordModel({
    this.userMessage,
    this.status,
  });

  factory ResetpasswordModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      ResetpasswordModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  ResetpasswordEntity toEntity() {
    return ResetpasswordEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
