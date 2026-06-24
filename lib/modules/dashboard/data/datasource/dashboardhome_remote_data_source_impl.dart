import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardhome_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardhome_model/dashboardhome_model.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardhome_param.dart';
import 'package:taxi_app/modules/googlemap/data/model/response/locationpick_model/locationpick_model.dart';

class DashboardhomeRemoteDataSourceImpl
    implements DashboardhomeRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  DashboardhomeRemoteDataSourceImpl(this.network, this.appUrl);

  @override
  Future<Either<RepoFailure, BaseJson<DashboardhomeModel>>> dashboardhome(
    DashboardhomeParam data,
  ) {
    return network
        .get(
          AppUrl.dashboardhomeUrl,
          ApiHeader.bearerHeaderOnly(data.token),
          query: data.toModel().toJson(),
        )
        .then(
          (value) =>
              value.fold((l) => left(RepoFailure(error: l.error)), (response) {
                try {
                  return right(
                    BaseJson<DashboardhomeModel>.fromJson(
                      response as Map<String, dynamic>,
                      DashboardhomeModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              }),
        );
  }

  @override
  Future<Either<RepoFailure, BaseJson<LocationpickModel>>> dashboardhomeAddress(
    DashboardhomeParam data,
  ) {
    return network
        .get(
          AppUrl.locationgetUrl,
          ApiHeader.bearerHeaderOnly(data.token),
        )
        .then(
          (value) =>
              value.fold((l) => left(RepoFailure(error: l.error)), (response) {
                try {
                  return right(
                    BaseJson<LocationpickModel>.fromJson(
                      response as Map<String, dynamic>,
                      LocationpickModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              }),
        );
  }
}
