import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardprofile_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/failures/dashboardprofile_failure.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardprofile_param.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardprofile_repo.dart';

class DashboardprofileUseCase {
  final DashboardprofileRepo _repo;

  DashboardprofileUseCase(this._repo);

  Future<
      Either<
          DashboardprofileFailure,
          BaseEntity<DashboardprofileEntity>>> execute(
    DashboardprofileParam data,
  ) async {
    return await _repo.dashboardprofile(data).then(
          (value) => value.fold(
            (err) => left(
              DashboardprofileFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
