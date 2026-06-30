import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/refreshtoken_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/refreshtoken_param.dart';

abstract class RefreshtokenRepo {
  Future<Either<RepoFailure, BaseEntity<RefreshtokenEntity>>> 
      refreshtoken(
    RefreshtokenParam param,
  );
}
