import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/activity/data/datasource/reserve_remote_data_source.dart';
import 'package:taxi_app/modules/activity/domain/entities/reserve_entity.dart';
import 'package:taxi_app/modules/activity/domain/params/reserve_param.dart';
import 'package:taxi_app/modules/activity/domain/repository/reserve_repo.dart';

class ReserveRestApiRepo implements ReserveRepo {
  final ReserveRemoteDataSource _dataSource;

  ReserveRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<ReserveEntity>>> 
      reserve(
    ReserveParam param,
  ) =>
      _dataSource.reserve(param).then(
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
