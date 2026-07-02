import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/core/network/network_service.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/activity/data/datasource/reserve_remote_data_source.dart';
import 'package:taxi_app/modules/activity/data/model/response/reserve_model/reserve_model.dart';
import 'package:taxi_app/modules/activity/domain/params/reserve_param.dart';

class ReserveRemoteDataSourceImpl
    implements ReserveRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  ReserveRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<ReserveModel>>> 
      reserve(ReserveParam data) =>
      network
          .post(
            AppUrl.reserveUrl,
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
                    BaseJson<ReserveModel>.fromJson(
                      response as Map<String, dynamic>,
                      ReserveModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
