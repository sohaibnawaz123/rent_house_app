import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardroot_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardroot_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardroot_param.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardroot_repo.dart';

class DashboardrootRestApiRepo implements DashboardrootRepo {
  final DashboardrootRemoteDataSource _dataSource;

  DashboardrootRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<DashboardrootEntity>>> 
      dashboardroot(
    DashboardrootParam param,
  ) =>
      _dataSource.dashboardroot(param).then(
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
