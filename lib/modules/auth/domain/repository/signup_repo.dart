import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/signup_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/signup_param.dart';

abstract class SignupRepo {
  Future<Either<RepoFailure, BaseEntity<SignupEntity>>> 
      signup(
    SignupParam param,
  );
}
