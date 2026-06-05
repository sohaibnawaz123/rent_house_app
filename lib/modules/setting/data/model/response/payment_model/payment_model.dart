import 'package:taxi_app/modules/setting/domain/entities/payment_entity.dart';

class PaymentModel {
  String? userMessage;
  bool? status;

  PaymentModel({
    this.userMessage,
    this.status,
  });

  factory PaymentModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      PaymentModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  PaymentEntity toEntity() {
    return PaymentEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
