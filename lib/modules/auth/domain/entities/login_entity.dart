class LoginEntity {
  final String userMessage;
  final bool status;

  LoginEntity({
    required this.userMessage,
    required this.status,
  });

  LoginEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return LoginEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
