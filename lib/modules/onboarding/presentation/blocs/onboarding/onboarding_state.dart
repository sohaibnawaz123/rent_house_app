part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  final OnboardingViewInitialParams initialParams;
  final ApiResponse<BaseEntity<OnboardingEntity>> onboardingResponse;
  final int currentPage;

  const OnboardingState({
    required this.initialParams,
    this.onboardingResponse = const ApiResponse.init(),
    this.currentPage = 0,
  });

  OnboardingState copyWith({
    int? currentPage,
    OnboardingViewInitialParams? initialParams,
    ApiResponse<BaseEntity<OnboardingEntity>>? onboardingResponse,
  }) {
    OnboardingState data = OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      initialParams: initialParams ?? this.initialParams,
      onboardingResponse: onboardingResponse ?? this.onboardingResponse,
    );
    Utils.logInfo(data.toString(), name: "Onboarding");
    return data;
  }

  @override
  List<Object?> get props => [initialParams, onboardingResponse, currentPage];

  @override
  String toString() {
    return 'OnboardingState(initialParams: $initialParams, onboardingResponse: ${onboardingResponse.toString()}, currentPage: $currentPage)';
  }
}
