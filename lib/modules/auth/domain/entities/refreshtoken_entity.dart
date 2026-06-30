class RefreshtokenEntity {
  final String userMessage;
  final bool status;

  RefreshtokenEntity({
    required this.userMessage,
    required this.status,
  });

  RefreshtokenEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return RefreshtokenEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
