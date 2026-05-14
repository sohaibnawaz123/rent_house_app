import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/register_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/register_param.dart';

abstract class RegisterRepo {
  Future<Either<RepoFailure, BaseEntity<RegisterEntity>>> 
      register(
    RegisterParam param,
  );
}
