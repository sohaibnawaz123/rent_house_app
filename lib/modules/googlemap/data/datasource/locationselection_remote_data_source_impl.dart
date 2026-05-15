import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/googlemap/data/datasource/locationselection_remote_data_source.dart';
import 'package:taxi_app/modules/googlemap/data/model/response/locationselection_model/locationselection_model.dart';
import 'package:taxi_app/modules/googlemap/domain/params/locationselection_param.dart';

class LocationselectionRemoteDataSourceImpl
    implements LocationselectionRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  LocationselectionRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<LocationselectionModel>>> 
      locationselection(LocationselectionParam data) =>
      network
          .get(
            AppUrl.locationselectionUrl,
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
                    BaseJson<LocationselectionModel>.fromJson(
                      response.data,
                          LocationselectionModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
