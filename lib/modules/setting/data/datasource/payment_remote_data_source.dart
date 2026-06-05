import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/setting/data/model/response/payment_model/payment_model.dart';
import 'package:taxi_app/modules/setting/domain/params/payment_param.dart';
abstract class PaymentRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<PaymentModel>>> payment(PaymentParam data);

}

