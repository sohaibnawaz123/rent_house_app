import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/features/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/onboarding/domain/entities/onboarding_entity.dart';
import 'package:taxi_app/modules/onboarding/domain/failures/onboarding_failure.dart';
import 'package:taxi_app/modules/onboarding/domain/params/onboarding_param.dart';
import 'package:taxi_app/modules/onboarding/domain/repository/onboarding_repo.dart';

class OnboardingUseCase {
  final OnboardingRepo _repo;

  OnboardingUseCase(this._repo);

  Future<
      Either<
          OnboardingFailure,
          BaseEntity<OnboardingEntity>>> execute(
    OnboardingParam data,
  ) async {
    return await _repo.onboarding(data).then(
          (value) => value.fold(
            (err) => left(
              OnboardingFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
