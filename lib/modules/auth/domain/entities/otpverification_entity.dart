class OtpverificationEntity {
  final String userMessage;
  final bool status;

  OtpverificationEntity({
    required this.userMessage,
    required this.status,
  });

  OtpverificationEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return OtpverificationEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
