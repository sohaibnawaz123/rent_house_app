import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardhome_param.dart';

abstract class DashboardhomeRepo {
  Future<Either<RepoFailure, BaseEntity<DashboardhomeEntity>>> 
      dashboardhome(
    DashboardhomeParam param,
  );
}
