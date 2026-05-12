class ForgetpasswordEntity {
  final String userMessage;
  final bool status;

  ForgetpasswordEntity({
    required this.userMessage,
    required this.status,
  });

  ForgetpasswordEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return ForgetpasswordEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
