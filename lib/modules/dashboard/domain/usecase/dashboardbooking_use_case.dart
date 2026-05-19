import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardbooking_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/failures/dashboardbooking_failure.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardbooking_param.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardbooking_repo.dart';

class DashboardbookingUseCase {
  final DashboardbookingRepo _repo;

  DashboardbookingUseCase(this._repo);

  Future<
      Either<
          DashboardbookingFailure,
          BaseEntity<DashboardbookingEntity>>> execute(
    DashboardbookingParam data,
  ) async {
    return await _repo.dashboardbooking(data).then(
          (value) => value.fold(
            (err) => left(
              DashboardbookingFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
