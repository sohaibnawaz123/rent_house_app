class DashboardbookingEntity {
  final String userMessage;
  final bool status;

  DashboardbookingEntity({
    required this.userMessage,
    required this.status,
  });

  DashboardbookingEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return DashboardbookingEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
