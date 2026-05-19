class DashboardrootEntity {
  final String userMessage;
  final bool status;

  DashboardrootEntity({
    required this.userMessage,
    required this.status,
  });

  DashboardrootEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return DashboardrootEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
