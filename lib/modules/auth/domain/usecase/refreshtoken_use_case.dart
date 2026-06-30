import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/refreshtoken_entity.dart';
import 'package:taxi_app/modules/auth/domain/failures/refreshtoken_failure.dart';
import 'package:taxi_app/modules/auth/domain/params/refreshtoken_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/refreshtoken_repo.dart';
import 'package:taxi_app/modules/auth/presentation/validator/refreshtoken_validator.dart';
import 'package:taxi_app/modules/auth/domain/failures/refreshtoken_failure.dart';

class RefreshtokenUseCase {
  final RefreshtokenValidator validator;
  final RefreshtokenRepo _repo;

  RefreshtokenUseCase(this.validator, this._repo);

  Future<
      Either<
          RefreshtokenFailure,
          BaseEntity<RefreshtokenEntity>>> execute(
    RefreshtokenParam data,
  ) async {
    return validator
        .validate(data)
        .fold(
          (l) => left(RefreshtokenFailure(error: l.error)),
          (r) async => await _repo.refreshtoken(data).then(
          (value) => value.fold(
            (err) => left(
              RefreshtokenFailure(error: err.error),
            ),
            (response) => right(response),
          )),
        );
  }
}

