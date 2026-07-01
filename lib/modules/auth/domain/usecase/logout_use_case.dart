import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/logout_entity.dart';
import 'package:taxi_app/modules/auth/domain/failures/logout_failure.dart';
import 'package:taxi_app/modules/auth/domain/params/logout_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/logout_repo.dart';
import 'package:taxi_app/modules/auth/presentation/validator/logout_validator.dart';

class LogoutUseCase {
  final LogoutValidator validator;
  final LogoutRepo _repo;

  LogoutUseCase(this.validator, this._repo);

  Future<Either<LogoutFailure, BaseEntity<LogoutEntity>>> execute(
    LogoutParam data,
  ) async {
    return validator.validate(data).fold(
      (l) => left(LogoutFailure(error: l.error)),
      (r) async => await _repo.logout(data).then(
        (value) => value.fold(
          (err) => left(LogoutFailure(error: err.error)),
          (response) => right(response),
        ),
      ),
    );
  }
}
