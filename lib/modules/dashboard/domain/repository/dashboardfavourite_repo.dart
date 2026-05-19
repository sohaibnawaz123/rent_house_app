import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardfavourite_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardfavourite_param.dart';

abstract class DashboardfavouriteRepo {
  Future<Either<RepoFailure, BaseEntity<DashboardfavouriteEntity>>> 
      dashboardfavourite(
    DashboardfavouriteParam param,
  );
}
