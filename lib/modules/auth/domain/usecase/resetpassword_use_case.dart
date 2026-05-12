import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/resetpassword_entity.dart';
import 'package:taxi_app/modules/auth/domain/failures/resetpassword_failure.dart';
import 'package:taxi_app/modules/auth/domain/params/resetpassword_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/resetpassword_repo.dart';
import 'package:taxi_app/modules/auth/presentation/validator/resetpassword_validator.dart';
import 'package:taxi_app/modules/auth/domain/failures/resetpassword_failure.dart';

class ResetpasswordUseCase {
  final ResetpasswordValidator validator;
  final ResetpasswordRepo _repo;

  ResetpasswordUseCase(this.validator, this._repo);

  Future<
      Either<
          ResetpasswordFailure,
          BaseEntity<ResetpasswordEntity>>> execute(
    ResetpasswordParam data,
  ) async {
    return validator
        .validate(data)
        .fold(
          (l) => left(ResetpasswordFailure(error: l.error)),
          (r) async => await _repo.resetpassword(data).then(
          (value) => value.fold(
            (err) => left(
              ResetpasswordFailure(error: err.error),
            ),
            (response) => right(response),
          )),
        );
  }
}

