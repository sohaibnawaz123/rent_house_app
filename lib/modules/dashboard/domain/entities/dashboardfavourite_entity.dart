class DashboardfavouriteEntity {
  final String userMessage;
  final bool status;

  DashboardfavouriteEntity({
    required this.userMessage,
    required this.status,
  });

  DashboardfavouriteEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return DashboardfavouriteEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
