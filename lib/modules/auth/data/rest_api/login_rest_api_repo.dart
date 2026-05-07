import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/data/datasource/login_remote_data_source.dart';
import 'package:taxi_app/modules/auth/domain/entities/login_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/login_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/login_repo.dart';

class LoginRestApiRepo implements LoginRepo {
  final LoginRemoteDataSource _dataSource;

  LoginRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<LoginEntity>>> 
      login(
    LoginParam param,
  ) =>
      _dataSource.login(param).then(
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
