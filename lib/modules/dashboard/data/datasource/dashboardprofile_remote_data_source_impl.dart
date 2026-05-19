import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardprofile_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardprofile_model/dashboardprofile_model.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardprofile_param.dart';

class DashboardprofileRemoteDataSourceImpl
    implements DashboardprofileRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  DashboardprofileRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<DashboardprofileModel>>> 
      dashboardprofile(DashboardprofileParam data) =>
      network
          .get(
            AppUrl.dashboardprofileUrl,
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
                    BaseJson<DashboardprofileModel>.fromJson(
                      response.data,
                          DashboardprofileModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
