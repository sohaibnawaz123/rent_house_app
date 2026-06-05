import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/setting/data/datasource/recent_remote_data_source.dart';
import 'package:taxi_app/modules/setting/data/model/response/recent_model/recent_model.dart';
import 'package:taxi_app/modules/setting/domain/params/recent_param.dart';

class RecentRemoteDataSourceImpl
    implements RecentRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  RecentRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<RecentModel>>> 
      recent(RecentParam data) =>
      network
          .get(
            AppUrl.recentUrl,
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
                    BaseJson<RecentModel>.fromJson(
                      response.data,
                          RecentModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
