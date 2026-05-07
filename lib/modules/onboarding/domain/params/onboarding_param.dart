import 'package:taxi_app/modules/onboarding/data/model/request/onboarding_request_model/onboarding_request_model.dart';

class OnboardingParam {
  final String token;
  final String email;

  const OnboardingParam({
    required this.token,
    required this.email,
  });

  OnboardingRequestModel toModel() => OnboardingRequestModel(
        token: token,
        email: email,
      );
}