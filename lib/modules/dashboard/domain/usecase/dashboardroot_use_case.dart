import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardroot_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/failures/dashboardroot_failure.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardroot_param.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardroot_repo.dart';

class DashboardrootUseCase {
  final DashboardrootRepo _repo;

  DashboardrootUseCase(this._repo);

  Future<
      Either<
          DashboardrootFailure,
          BaseEntity<DashboardrootEntity>>> execute(
    DashboardrootParam data,
  ) async {
    return await _repo.dashboardroot(data).then(
          (value) => value.fold(
            (err) => left(
              DashboardrootFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
