class DashboardprofileEntity {
  final String userMessage;
  final bool status;

  DashboardprofileEntity({
    required this.userMessage,
    required this.status,
  });

  DashboardprofileEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return DashboardprofileEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
