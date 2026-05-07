import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/data/datasource/signup_remote_data_source.dart';
import 'package:taxi_app/modules/auth/domain/entities/signup_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/signup_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/signup_repo.dart';

class SignupRestApiRepo implements SignupRepo {
  final SignupRemoteDataSource _dataSource;

  SignupRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<SignupEntity>>> 
      signup(
    SignupParam param,
  ) =>
      _dataSource.signup(param).then(
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
