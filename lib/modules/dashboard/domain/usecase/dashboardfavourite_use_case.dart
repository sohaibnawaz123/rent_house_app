import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardfavourite_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/failures/dashboardfavourite_failure.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardfavourite_param.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardfavourite_repo.dart';

class DashboardfavouriteUseCase {
  final DashboardfavouriteRepo _repo;

  DashboardfavouriteUseCase(this._repo);

  Future<
      Either<
          DashboardfavouriteFailure,
          BaseEntity<DashboardfavouriteEntity>>> execute(
    DashboardfavouriteParam data,
  ) async {
    return await _repo.dashboardfavourite(data).then(
          (value) => value.fold(
            (err) => left(
              DashboardfavouriteFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
