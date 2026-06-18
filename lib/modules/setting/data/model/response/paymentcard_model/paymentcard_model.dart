import 'package:taxi_app/modules/setting/domain/entities/paymentcard_entity.dart';

class PaymentcardModel {
  String? userMessage;
  bool? status;

  PaymentcardModel({
    this.userMessage,
    this.status,
  });

  factory PaymentcardModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      PaymentcardModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  PaymentcardEntity toEntity() {
    return PaymentcardEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
