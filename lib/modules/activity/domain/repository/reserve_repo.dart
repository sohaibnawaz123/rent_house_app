import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/activity/domain/entities/reserve_entity.dart';
import 'package:taxi_app/modules/activity/domain/params/reserve_param.dart';

abstract class ReserveRepo {
  Future<Either<RepoFailure, BaseEntity<ReserveEntity>>> 
      reserve(
    ReserveParam param,
  );
}
