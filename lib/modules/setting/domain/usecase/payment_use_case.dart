import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/payment_entity.dart';
import 'package:taxi_app/modules/setting/domain/failures/payment_failure.dart';
import 'package:taxi_app/modules/setting/domain/params/payment_param.dart';
import 'package:taxi_app/modules/setting/domain/repository/payment_repo.dart';

class PaymentUseCase {
  final PaymentRepo _repo;

  PaymentUseCase(this._repo);

  Future<
      Either<
          PaymentFailure,
          BaseEntity<PaymentEntity>>> execute(
    PaymentParam data,
  ) async {
    return await _repo.payment(data).then(
          (value) => value.fold(
            (err) => left(
              PaymentFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
