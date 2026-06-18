class PaymentcardEntity {
  final String userMessage;
  final bool status;

  PaymentcardEntity({
    required this.userMessage,
    required this.status,
  });

  PaymentcardEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return PaymentcardEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
