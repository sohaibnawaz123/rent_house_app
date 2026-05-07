import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/features/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/onboarding/data/datasource/onboarding_remote_data_source.dart';
import 'package:taxi_app/modules/onboarding/domain/entities/onboarding_entity.dart';
import 'package:taxi_app/modules/onboarding/domain/params/onboarding_param.dart';
import 'package:taxi_app/modules/onboarding/domain/repository/onboarding_repo.dart';

class OnboardingRestApiRepo implements OnboardingRepo {
  final OnboardingRemoteDataSource _dataSource;

  OnboardingRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<OnboardingEntity>>> 
      onboarding(
    OnboardingParam param,
  ) =>
      _dataSource.onboarding(param).then(
        (value) => value.fold(
          (l) => left(RepoFailure(error: l.error)),
          (response) {
            try {
              return right(
                response.toDomain(
                  (val) => val!.toEntity(),
                ),
              );
            } catch (e) {
              return left(RepoFailure(error: e.toString()));
            }
          },
        ),
      );
}
