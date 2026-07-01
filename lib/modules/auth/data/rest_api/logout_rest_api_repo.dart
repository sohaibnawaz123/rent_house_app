import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/data/datasource/logout_remote_data_source.dart';
import 'package:taxi_app/modules/auth/domain/entities/logout_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/logout_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/logout_repo.dart';

class LogoutRestApiRepo implements LogoutRepo {
  final LogoutRemoteDataSource _dataSource;

  LogoutRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<LogoutEntity>>> logout(
    LogoutParam param,
  ) {
    return _dataSource.logout(param).then(
      (value) => value.fold(
        (l) => left(RepoFailure(error: l.error)),
        (response) {
          try {
            return right(
              BaseEntity<LogoutEntity>(
                message: response.message ?? '',
                data: response.toEntity(),
              ),
            );
          } catch (e) {
            return left(RepoFailure(error: e.toString()));
          }
        },
      ),
    );
  }
}
