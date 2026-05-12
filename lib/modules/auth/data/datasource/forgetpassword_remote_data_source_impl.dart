import 'package:fpdart/fpdart.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/core/network/network_service.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/auth/data/datasource/forgetpassword_remote_data_source.dart';
import 'package:taxi_app/modules/auth/data/model/response/forgetpassword_model/forgetpassword_model.dart';
import 'package:taxi_app/modules/auth/domain/params/forgetpassword_param.dart';

class ForgetpasswordRemoteDataSourceImpl
    implements ForgetpasswordRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  ForgetpasswordRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<ForgetpasswordModel>>> 
      forgetpassword(ForgetpasswordParam data) =>
      network
          .post(
            AppUrl.forgetpasswordUrl,
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
                    BaseJson<ForgetpasswordModel>.fromJson(
                      response.data,
                          ForgetpasswordModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
