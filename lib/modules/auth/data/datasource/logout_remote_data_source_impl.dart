import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/core/network/network_service.dart';
import 'package:taxi_app/modules/auth/data/datasource/logout_remote_data_source.dart';
import 'package:taxi_app/modules/auth/data/model/response/logout_model/logout_model.dart';
import 'package:taxi_app/modules/auth/domain/params/logout_param.dart';

class LogoutRemoteDataSourceImpl implements LogoutRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  LogoutRemoteDataSourceImpl(this.network, this.appUrl);

  @override
  Future<Either<RepoFailure, LogoutModel>> logout(LogoutParam data) {
    return network
        .postWithoutBody(
          AppUrl.logoutUrl,
          ApiHeader.bearerHeaderWithApplicationJson(data.accessToken),
        )
        .then(
          (value) => value.fold(
            (l) => left(RepoFailure(error: l.error)),
            (response) {
              try {
                return right(
                  LogoutModel.fromJson(response as Map<String, dynamic>),
                );
              } catch (e) {
                return left(RepoFailure(error: e.toString()));
              }
            },
          ),
        );
  }
}
