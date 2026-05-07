class SignupEntity {
  final String userMessage;
  final bool status;

  SignupEntity({
    required this.userMessage,
    required this.status,
  });

  SignupEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return SignupEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
