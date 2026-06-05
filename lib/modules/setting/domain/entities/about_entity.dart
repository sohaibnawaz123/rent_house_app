class AboutEntity {
  final String userMessage;
  final bool status;

  AboutEntity({
    required this.userMessage,
    required this.status,
  });

  AboutEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return AboutEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
