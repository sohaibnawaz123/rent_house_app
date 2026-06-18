import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/paymentcard_entity.dart';
import 'package:taxi_app/modules/setting/domain/failures/paymentcard_failure.dart';
import 'package:taxi_app/modules/setting/domain/params/paymentcard_param.dart';
import 'package:taxi_app/modules/setting/domain/repository/paymentcard_repo.dart';
import 'package:taxi_app/modules/setting/presentation/validator/paymentcard_validator.dart';
import 'package:taxi_app/modules/setting/domain/failures/paymentcard_failure.dart';

class PaymentcardUseCase {
  final PaymentcardValidator validator;
  final PaymentcardRepo _repo;

  PaymentcardUseCase(this.validator, this._repo);

  Future<
      Either<
          PaymentcardFailure,
          BaseEntity<PaymentcardEntity>>> execute(
    PaymentcardParam data,
  ) async {
    return validator
        .validate(data)
        .fold(
          (l) => left(PaymentcardFailure(error: l.error)),
          (r) async => await _repo.paymentcard(data).then(
          (value) => value.fold(
            (err) => left(
              PaymentcardFailure(error: err.error),
            ),
            (response) => right(response),
          )),
        );
  }
}

