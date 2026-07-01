class RefreshtokenEntity {
  final String message;
  final String accessToken;
  final String refreshToken;

  RefreshtokenEntity({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
  });

  RefreshtokenEntity copyWith({
    String? message,
    String? accessToken,
    String? refreshToken,
  }) {
    return RefreshtokenEntity(
      message: message ?? this.message,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
