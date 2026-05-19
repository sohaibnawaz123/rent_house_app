import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardfavourite_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardfavourite_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardfavourite_param.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardfavourite_repo.dart';

class DashboardfavouriteRestApiRepo implements DashboardfavouriteRepo {
  final DashboardfavouriteRemoteDataSource _dataSource;

  DashboardfavouriteRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<DashboardfavouriteEntity>>> 
      dashboardfavourite(
    DashboardfavouriteParam param,
  ) =>
      _dataSource.dashboardfavourite(param).then(
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
