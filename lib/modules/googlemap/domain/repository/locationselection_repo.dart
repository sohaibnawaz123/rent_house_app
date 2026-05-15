import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/entities/locationselection_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/params/locationselection_param.dart';

abstract class LocationselectionRepo {
  Future<Either<RepoFailure, BaseEntity<LocationselectionEntity>>> 
      locationselection(
    LocationselectionParam param,
  );
}
