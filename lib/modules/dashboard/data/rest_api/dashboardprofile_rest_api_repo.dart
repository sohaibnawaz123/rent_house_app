import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardprofile_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardprofile_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardprofile_param.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardprofile_repo.dart';

class DashboardprofileRestApiRepo implements DashboardprofileRepo {
  final DashboardprofileRemoteDataSource _dataSource;

  DashboardprofileRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<DashboardprofileEntity>>> 
      dashboardprofile(
    DashboardprofileParam param,
  ) =>
      _dataSource.dashboardprofile(param).then(
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
