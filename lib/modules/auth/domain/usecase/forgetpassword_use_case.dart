import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/forgetpassword_entity.dart';
import 'package:taxi_app/modules/auth/domain/failures/forgetpassword_failure.dart';
import 'package:taxi_app/modules/auth/domain/params/forgetpassword_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/forgetpassword_repo.dart';
import 'package:taxi_app/modules/auth/presentation/validator/forgetpassword_validator.dart';
import 'package:taxi_app/modules/auth/domain/failures/forgetpassword_failure.dart';

class ForgetpasswordUseCase {
  final ForgetpasswordValidator validator;
  final ForgetpasswordRepo _repo;

  ForgetpasswordUseCase(this.validator, this._repo);

  Future<
      Either<
          ForgetpasswordFailure,
          BaseEntity<ForgetpasswordEntity>>> execute(
    ForgetpasswordParam data,
  ) async {
    return validator
        .validate(data)
        .fold(
          (l) => left(ForgetpasswordFailure(error: l.error)),
          (r) async => await _repo.forgetpassword(data).then(
          (value) => value.fold(
            (err) => left(
              ForgetpasswordFailure(error: err.error),
            ),
            (response) => right(response),
          )),
        );
  }
}

