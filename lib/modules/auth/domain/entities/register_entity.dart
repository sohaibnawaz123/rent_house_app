class RegisterEntity {
  final String userMessage;
  final bool status;

  RegisterEntity({
    required this.userMessage,
    required this.status,
  });

  RegisterEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return RegisterEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
