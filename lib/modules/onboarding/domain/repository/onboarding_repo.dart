import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/features/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/onboarding/domain/entities/onboarding_entity.dart';
import 'package:taxi_app/modules/onboarding/domain/params/onboarding_param.dart';

abstract class OnboardingRepo {
  Future<Either<RepoFailure, BaseEntity<OnboardingEntity>>> 
      onboarding(
    OnboardingParam param,
  );
}
