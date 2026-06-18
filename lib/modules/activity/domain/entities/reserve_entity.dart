class ReserveEntity {
  final String userMessage;
  final bool status;

  ReserveEntity({
    required this.userMessage,
    required this.status,
  });

  ReserveEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return ReserveEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
