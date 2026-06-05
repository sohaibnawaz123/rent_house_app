class PaymentEntity {
  final String userMessage;
  final bool status;

  PaymentEntity({
    required this.userMessage,
    required this.status,
  });

  PaymentEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return PaymentEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
