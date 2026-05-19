import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardexplore_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardexplore_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardexplore_param.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardexplore_repo.dart';

class DashboardexploreRestApiRepo implements DashboardexploreRepo {
  final DashboardexploreRemoteDataSource _dataSource;

  DashboardexploreRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<DashboardexploreEntity>>> 
      dashboardexplore(
    DashboardexploreParam param,
  ) =>
      _dataSource.dashboardexplore(param).then(
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
