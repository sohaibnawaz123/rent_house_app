import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardexplore_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardexplore_model/dashboardexplore_model.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardexplore_param.dart';

class DashboardexploreRemoteDataSourceImpl
    implements DashboardexploreRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  DashboardexploreRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<DashboardexploreModel>>> 
      dashboardexplore(DashboardexploreParam data) =>
      network
          .get(
            AppUrl.dashboardexploreUrl,
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
                    BaseJson<DashboardexploreModel>.fromJson(
                      response.data,
                          DashboardexploreModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
