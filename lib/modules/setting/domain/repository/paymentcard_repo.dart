import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/paymentcard_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/paymentcard_param.dart';

abstract class PaymentcardRepo {
  Future<Either<RepoFailure, BaseEntity<PaymentcardEntity>>> 
      paymentcard(
    PaymentcardParam param,
  );
}
