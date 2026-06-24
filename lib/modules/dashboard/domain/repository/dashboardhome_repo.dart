import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/dashboardhome_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardhome_param.dart';
import 'package:taxi_app/modules/googlemap/domain/entities/locationpick_entity.dart';

abstract class DashboardhomeRepo {
  Future<Either<RepoFailure, BaseEntity<DashboardhomeEntity>>> dashboardhome(
    DashboardhomeParam param,
  );

  Future<Either<RepoFailure, BaseEntity<LocationpickEntity>>> dashboardhomeAddress(
    DashboardhomeParam param,
  );
}
