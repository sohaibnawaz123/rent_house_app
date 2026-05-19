class DashboardhomeEntity {
  final String userMessage;
  final bool status;

  DashboardhomeEntity({
    required this.userMessage,
    required this.status,
  });

  DashboardhomeEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return DashboardhomeEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
