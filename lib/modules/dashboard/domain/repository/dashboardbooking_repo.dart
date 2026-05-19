import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardbooking_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardbooking_param.dart';

abstract class DashboardbookingRepo {
  Future<Either<RepoFailure, BaseEntity<DashboardbookingEntity>>> 
      dashboardbooking(
    DashboardbookingParam param,
  );
}
