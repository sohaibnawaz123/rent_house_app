import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/data/datasource/refreshtoken_remote_data_source.dart';
import 'package:taxi_app/modules/auth/domain/entities/refreshtoken_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/refreshtoken_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/refreshtoken_repo.dart';

class RefreshtokenRestApiRepo implements RefreshtokenRepo {
  final RefreshtokenRemoteDataSource _dataSource;

  RefreshtokenRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<RefreshtokenEntity>>> 
      refreshtoken(
    RefreshtokenParam param,
  ) =>
      _dataSource.refreshtoken(param).then(
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
