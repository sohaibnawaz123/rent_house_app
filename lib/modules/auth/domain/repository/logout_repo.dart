import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/logout_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/logout_param.dart';

abstract class LogoutRepo {
  Future<Either<RepoFailure, BaseEntity<LogoutEntity>>> logout(
    LogoutParam param,
  );
}
