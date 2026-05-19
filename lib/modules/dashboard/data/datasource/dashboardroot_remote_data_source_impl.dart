import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardroot_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardroot_model/dashboardroot_model.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardroot_param.dart';

class DashboardrootRemoteDataSourceImpl
    implements DashboardrootRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  DashboardrootRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<DashboardrootModel>>> 
      dashboardroot(DashboardrootParam data) =>
      network
          .get(
            AppUrl.dashboardrootUrl,
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
                    BaseJson<DashboardrootModel>.fromJson(
                      response.data,
                          DashboardrootModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
