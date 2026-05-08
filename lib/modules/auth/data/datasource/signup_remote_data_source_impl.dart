import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/core/network/network.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/auth/data/datasource/signup_remote_data_source.dart';
import 'package:taxi_app/modules/auth/data/model/response/signup_model/signup_model.dart';
import 'package:taxi_app/modules/auth/domain/params/signup_param.dart';

class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  final Network network;
  final AppUrl appUrl;

  SignupRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<SignupModel>>> signup(
    SignupParam data,
  ) =>
      network
          .get(
            AppUrl.signupUrl,
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
                    BaseJson<SignupModel>.fromJson(
                      response.data,
                      SignupModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
