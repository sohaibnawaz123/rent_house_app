import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardhome_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardhome_param.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardhome_repo.dart';

class DashboardhomeRestApiRepo implements DashboardhomeRepo {
  final DashboardhomeRemoteDataSource _dataSource;

  DashboardhomeRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<DashboardhomeEntity>>> 
      dashboardhome(
    DashboardhomeParam param,
  ) =>
      _dataSource.dashboardhome(param).then(
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
