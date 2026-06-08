class PropertydetailEntity {
  final String userMessage;
  final bool status;

  PropertydetailEntity({
    required this.userMessage,
    required this.status,
  });

  PropertydetailEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return PropertydetailEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
