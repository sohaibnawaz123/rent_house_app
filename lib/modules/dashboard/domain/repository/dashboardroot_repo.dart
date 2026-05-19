import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardroot_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardroot_param.dart';

abstract class DashboardrootRepo {
  Future<Either<RepoFailure, BaseEntity<DashboardrootEntity>>> 
      dashboardroot(
    DashboardrootParam param,
  );
}
