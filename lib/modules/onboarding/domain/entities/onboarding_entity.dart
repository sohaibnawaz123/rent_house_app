class OnboardingEntity {
  final String userMessage;
  final bool status;

  OnboardingEntity({
    required this.userMessage,
    required this.status,
  });

  OnboardingEntity copyWith({
    String? userMessage,
    bool? status,
  }) {
    return OnboardingEntity(
      userMessage: userMessage ?? this.userMessage,
      status: status ?? this.status,
    );
  }
}
