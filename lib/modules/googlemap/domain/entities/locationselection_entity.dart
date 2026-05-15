class LocationselectionEntity {
  final String userMessage;
  final bool status;

  LocationselectionEntity({
    required this.userMessage,
    required this.status,
  });

  LocationselectionEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return LocationselectionEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
