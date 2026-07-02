import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardfavourite_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardfavourite_model/dashboardfavourite_model.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardfavourite_param.dart';

class DashboardfavouriteRemoteDataSourceImpl
    implements DashboardfavouriteRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  DashboardfavouriteRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<DashboardfavouriteModel>>> 
      dashboardfavourite(DashboardfavouriteParam data) =>
      network
          .get(
            AppUrl.dashboardfavouriteUrl,
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
                    BaseJson<DashboardfavouriteModel>.fromJson(
                      response as Map<String, dynamic>,
                      DashboardfavouriteModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
