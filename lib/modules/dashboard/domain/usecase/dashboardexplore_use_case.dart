import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardexplore_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/failures/dashboardexplore_failure.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardexplore_param.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardexplore_repo.dart';

class DashboardexploreUseCase {
  final DashboardexploreRepo _repo;

  DashboardexploreUseCase(this._repo);

  Future<
      Either<
          DashboardexploreFailure,
          BaseEntity<DashboardexploreEntity>>> execute(
    DashboardexploreParam data,
  ) async {
    return await _repo.dashboardexplore(data).then(
          (value) => value.fold(
            (err) => left(
              DashboardexploreFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
