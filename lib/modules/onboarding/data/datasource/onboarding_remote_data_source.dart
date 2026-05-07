import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/onboarding/data/model/response/onboarding_model/onboarding_model.dart';
import 'package:taxi_app/modules/onboarding/domain/params/onboarding_param.dart';
abstract class OnboardingRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<OnboardingModel>>> onboarding(OnboardingParam data);

}

