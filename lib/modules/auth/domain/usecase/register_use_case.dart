import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/register_entities/register_entity.dart';
import 'package:taxi_app/modules/auth/domain/failures/register_failure.dart';
import 'package:taxi_app/modules/auth/domain/params/register_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/register_repo.dart';
import 'package:taxi_app/modules/auth/presentation/validator/register_validator.dart';

class RegisterUseCase {
  final RegisterValidator validator;
  final RegisterRepo _repo;

  RegisterUseCase(this.validator, this._repo);

  Future<
      Either<
          RegisterFailure,
          BaseEntity<RegisterEntity>>> execute(
    RegisterParam data,
  ) async {
    return validator
        .validate(data)
        .fold(
          (l) => left(RegisterFailure(error: l.error)),
          (r) async => await _repo.register(data).then(
          (value) => value.fold(
            (err) => left(
              RegisterFailure(error: err.error),
            ),
            (response) => right(response),
          )),
        );
  }
}

