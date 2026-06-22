import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/core/network/network_service.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/auth/data/datasource/resetpassword_remote_data_source.dart';
import 'package:taxi_app/modules/auth/data/model/response/resetpassword_model/resetpassword_model.dart';
import 'package:taxi_app/modules/auth/domain/params/resetpassword_param.dart';

class ResetpasswordRemoteDataSourceImpl
    implements ResetpasswordRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  ResetpasswordRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<ResetpasswordModel>>> 
      resetpassword(ResetpasswordParam data) =>
      network
          .post(
            AppUrl.resetpasswordUrl,
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
                    BaseJson<ResetpasswordModel>.fromJson(
                      response as Map<String, dynamic>,
                      ResetpasswordModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
