class DashboardexploreEntity {
  final String userMessage;
  final bool status;

  DashboardexploreEntity({
    required this.userMessage,
    required this.status,
  });

  DashboardexploreEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return DashboardexploreEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
