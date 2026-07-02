import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardbooking_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardbooking_model/dashboardbooking_model.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardbooking_param.dart';

class DashboardbookingRemoteDataSourceImpl
    implements DashboardbookingRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  DashboardbookingRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<DashboardbookingModel>>> 
      dashboardbooking(DashboardbookingParam data) =>
      network
          .get(
            AppUrl.dashboardbookingUrl,
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
                    BaseJson<DashboardbookingModel>.fromJson(
                      response as Map<String, dynamic>,
                      DashboardbookingModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
