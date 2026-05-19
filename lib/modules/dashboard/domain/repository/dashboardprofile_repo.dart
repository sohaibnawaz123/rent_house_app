import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardprofile_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardprofile_param.dart';

abstract class DashboardprofileRepo {
  Future<Either<RepoFailure, BaseEntity<DashboardprofileEntity>>> 
      dashboardprofile(
    DashboardprofileParam param,
  );
}
