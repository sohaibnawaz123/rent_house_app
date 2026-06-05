class EditprofileEntity {
  final String userMessage;
  final bool status;

  EditprofileEntity({
    required this.userMessage,
    required this.status,
  });

  EditprofileEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return EditprofileEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
