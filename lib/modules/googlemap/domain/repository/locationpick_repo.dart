import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/entities/locationpick_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/params/locationpick_param.dart';

abstract class LocationpickRepo {
  Future<Either<RepoFailure, BaseEntity<LocationpickEntity>>> 
      locationpick(
    LocationpickParam param,
  );
}
