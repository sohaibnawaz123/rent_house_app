import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/setting/data/datasource/payment_remote_data_source.dart';
import 'package:taxi_app/modules/setting/data/model/response/payment_model/payment_model.dart';
import 'package:taxi_app/modules/setting/domain/params/payment_param.dart';

class PaymentRemoteDataSourceImpl
    implements PaymentRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  PaymentRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<PaymentModel>>> 
      payment(PaymentParam data) =>
      network
          .get(
            AppUrl.paymentUrl,
            ApiHeader.json(),
            query: data.toModel().toJson(),
        // authType: AuthType.cookie,
          )
          .then(
            (value) => value.fold(
              (l) => left(RepoFailure(error: l.error)),
              (response) {
                try {
                  return right(
                    BaseJson<PaymentModel>.fromJson(
                      response.data,
                          PaymentModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
