import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/otpverification_entity.dart';
import 'package:taxi_app/modules/auth/domain/failures/otpverification_failure.dart';
import 'package:taxi_app/modules/auth/domain/params/otpverification_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/otpverification_repo.dart';
import 'package:taxi_app/modules/auth/presentation/validator/otpverification_validator.dart';

class OtpverificationUseCase {
  final OtpverificationValidator validator;
  final OtpverificationRepo _repo;

  OtpverificationUseCase(this.validator, this._repo);

  Future<
      Either<
          OtpverificationFailure,
          BaseEntity<OtpverificationEntity>>> execute(
    OtpverificationParam data,
  ) async {
    return validator
        .validate(data)
        .fold(
          (l) => left(OtpverificationFailure(error: l.error)),
          (r) async => await _repo.otpverification(data).then(
          (value) => value.fold(
            (err) => left(
              OtpverificationFailure(error: err.error),
            ),
            (response) => right(response),
          )),
        );
  }
}

