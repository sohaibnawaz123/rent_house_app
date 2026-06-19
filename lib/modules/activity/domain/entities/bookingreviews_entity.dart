class BookingreviewsEntity {
  final String userMessage;
  final bool status;

  BookingreviewsEntity({
    required this.userMessage,
    required this.status,
  });

  BookingreviewsEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return BookingreviewsEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
