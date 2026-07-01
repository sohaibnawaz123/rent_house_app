import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/core/network/network_service.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/auth/data/datasource/refreshtoken_remote_data_source.dart';
import 'package:taxi_app/modules/auth/data/model/response/refreshtoken_model/refreshtoken_model.dart';
import 'package:taxi_app/modules/auth/domain/params/refreshtoken_param.dart';

class RefreshtokenRemoteDataSourceImpl
    implements RefreshtokenRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  RefreshtokenRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<RefreshtokenModel>>>
      refreshtoken(RefreshtokenParam data) =>
      network
          .post(
            AppUrl.refreshtokenUrl,
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
                    BaseJson<RefreshtokenModel>.fromJson(
                      response as Map<String, dynamic>,
                      RefreshtokenModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
