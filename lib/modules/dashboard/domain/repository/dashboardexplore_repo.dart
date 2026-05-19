import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardexplore_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardexplore_param.dart';

abstract class DashboardexploreRepo {
  Future<Either<RepoFailure, BaseEntity<DashboardexploreEntity>>> 
      dashboardexplore(
    DashboardexploreParam param,
  );
}
