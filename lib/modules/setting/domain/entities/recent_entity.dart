class RecentEntity {
  final String userMessage;
  final bool status;

  RecentEntity({
    required this.userMessage,
    required this.status,
  });

  RecentEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return RecentEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
