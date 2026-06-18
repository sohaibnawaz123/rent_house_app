import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/activity/domain/entities/reserve_entity.dart';
import 'package:taxi_app/modules/activity/domain/failures/reserve_failure.dart';
import 'package:taxi_app/modules/activity/domain/params/reserve_param.dart';
import 'package:taxi_app/modules/activity/domain/repository/reserve_repo.dart';
import 'package:taxi_app/modules/activity/presentation/validator/reserve_validator.dart';

class ReserveUseCase {
  final ReserveValidator validator;
  final ReserveRepo _repo;

  ReserveUseCase(this.validator, this._repo);

  Future<
      Either<
          ReserveFailure,
          BaseEntity<ReserveEntity>>> execute(
    ReserveParam data,
  ) async {
    return validator
        .validate(data)
        .fold(
          (l) => left(ReserveFailure(error: l.error)),
          (r) async => await _repo.reserve(data).then(
          (value) => value.fold(
            (err) => left(
              ReserveFailure(error: err.error),
            ),
            (response) => right(response),
          )),
        );
  }
}

