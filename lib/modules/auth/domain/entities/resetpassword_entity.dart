class ResetpasswordEntity {
  final String userMessage;
  final bool status;

  ResetpasswordEntity({
    required this.userMessage,
    required this.status,
  });

  ResetpasswordEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return ResetpasswordEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
