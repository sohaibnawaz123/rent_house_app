class LocationpickEntity {
  final String userMessage;
  final bool status;

  LocationpickEntity({
    required this.userMessage,
    required this.status,
  });

  LocationpickEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return LocationpickEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
