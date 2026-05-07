part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  final OnboardingViewInitialParams initialParams;
  final ApiResponse<BaseEntity<OnboardingEntity>> onboardingResponse;

  const OnboardingState({
    required this.initialParams,
    this.onboardingResponse = const ApiResponse.init(),
  });

   OnboardingState copyWith({
    OnboardingViewInitialParams? initialParams,
    ApiResponse<BaseEntity<OnboardingEntity>>? onboardingResponse,
  }) {
    OnboardingState data =   OnboardingState(
      initialParams: initialParams ?? this.initialParams,
      onboardingResponse: onboardingResponse ?? this.onboardingResponse,
    );
    Utils.logInfo(data.toString(), name: "Onboarding");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, onboardingResponse];

  @override
  String toString() {
    return 'OnboardingState(initialParams: $initialParams, onboardingResponse: ${onboardingResponse.toString()})';
  }
}
