class NotificationEntity {
  final String userMessage;
  final bool status;

  NotificationEntity({
    required this.userMessage,
    required this.status,
  });

  NotificationEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return NotificationEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
