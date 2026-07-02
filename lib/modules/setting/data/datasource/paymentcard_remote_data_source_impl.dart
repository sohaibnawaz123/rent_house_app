import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/core/network/network_service.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/setting/data/datasource/paymentcard_remote_data_source.dart';
import 'package:taxi_app/modules/setting/data/model/response/paymentcard_model/paymentcard_model.dart';
import 'package:taxi_app/modules/setting/domain/params/paymentcard_param.dart';

class PaymentcardRemoteDataSourceImpl
    implements PaymentcardRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  PaymentcardRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<PaymentcardModel>>> 
      paymentcard(PaymentcardParam data) =>
      network
          .post(
            AppUrl.paymentcardUrl,
             data.toModel().toJson(),
            ApiHeader.json(),
        // authType: AuthType.cookie,

          )
          .then(
            (value) => value.fold(
              (l) => left(RepoFailure(error: l.error)),
              (response) {
                try {
                  return right(
                    BaseJson<PaymentcardModel>.fromJson(
                      response as Map<String, dynamic>,
                      PaymentcardModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
