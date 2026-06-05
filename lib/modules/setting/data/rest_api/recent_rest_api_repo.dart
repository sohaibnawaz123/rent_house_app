import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/data/datasource/recent_remote_data_source.dart';
import 'package:taxi_app/modules/setting/domain/entities/recent_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/recent_param.dart';
import 'package:taxi_app/modules/setting/domain/repository/recent_repo.dart';

class RecentRestApiRepo implements RecentRepo {
  final RecentRemoteDataSource _dataSource;

  RecentRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<RecentEntity>>> 
      recent(
    RecentParam param,
  ) =>
      _dataSource.recent(param).then(
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
