import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/setting/data/model/response/paymentcard_model/paymentcard_model.dart';
import 'package:taxi_app/modules/setting/domain/params/paymentcard_param.dart';
abstract class PaymentcardRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<PaymentcardModel>>> paymentcard(PaymentcardParam data);

}

