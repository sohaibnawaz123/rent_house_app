import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/dashboardhome_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/failures/dashboardhome_failure.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardhome_param.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardhome_repo.dart';
import 'package:taxi_app/modules/googlemap/domain/entities/locationpick_entity.dart';

class DashboardhomeUseCase {
  final DashboardhomeRepo _repo;

  DashboardhomeUseCase(this._repo);

  Future<Either<DashboardhomeFailure, BaseEntity<DashboardhomeEntity>>> execute(
    DashboardhomeParam data,
  ) async {
    return await _repo.dashboardhome(data).then(
          (value) => value.fold(
            (err) => left(
              DashboardhomeFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }

  Future<Either<DashboardhomeFailure, BaseEntity<LocationpickEntity>>>
  executeAddress(DashboardhomeParam data) async {
    return _repo.dashboardhomeAddress(data).then(
      (value) => value.fold(
        (err) => left(DashboardhomeFailure(error: err.error)),
        right,
      ),
    );
  }
}
