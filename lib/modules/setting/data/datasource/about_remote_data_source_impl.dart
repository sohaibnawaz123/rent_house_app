import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/setting/data/datasource/about_remote_data_source.dart';
import 'package:taxi_app/modules/setting/data/model/response/about_model/about_model.dart';
import 'package:taxi_app/modules/setting/domain/params/about_param.dart';

class AboutRemoteDataSourceImpl
    implements AboutRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  AboutRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<AboutModel>>> 
      about(AboutParam data) =>
      network
          .get(
            AppUrl.aboutUrl,
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
                    BaseJson<AboutModel>.fromJson(
                      response.data,
                          AboutModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
