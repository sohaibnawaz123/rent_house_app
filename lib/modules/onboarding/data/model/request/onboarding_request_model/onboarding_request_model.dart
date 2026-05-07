
import 'package:taxi_app/modules/onboarding/domain/params/onboarding_param.dart';

class OnboardingRequestModel extends OnboardingParam {
  const OnboardingRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}