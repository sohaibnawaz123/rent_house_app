import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/otpverification_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/otpverification_param.dart';

abstract class OtpverificationRepo {
  Future<Either<RepoFailure, BaseEntity<OtpverificationEntity>>> 
      otpverification(
    OtpverificationParam param,
  );
}
