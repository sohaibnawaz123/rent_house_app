import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/payment_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/payment_param.dart';

abstract class PaymentRepo {
  Future<Either<RepoFailure, BaseEntity<PaymentEntity>>> 
      payment(
    PaymentParam param,
  );
}
