import 'package:taxi_app/modules/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingModel {
  String? userMessage;
  bool? status;

  OnboardingModel({
    this.userMessage,
    this.status,
  });

  factory OnboardingModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      OnboardingModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  OnboardingEntity toEntity() {
    return OnboardingEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
