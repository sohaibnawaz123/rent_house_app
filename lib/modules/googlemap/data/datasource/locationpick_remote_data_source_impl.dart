import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/core/store/store_preference.dart';
import 'package:taxi_app/core/store/user_store_key.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/googlemap/data/datasource/locationpick_remote_data_source.dart';
import 'package:taxi_app/modules/googlemap/data/model/response/locationpick_model/locationpick_model.dart';
import 'package:taxi_app/modules/googlemap/domain/params/locationpick_param.dart';

class LocationpickRemoteDataSourceImpl implements LocationpickRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  LocationpickRemoteDataSourceImpl(this.network, this.appUrl);

  @override
  Future<Either<RepoFailure, BaseJson<LocationpickModel>>> locationpick(
    LocationpickParam data,
  ) {
    final token = StorePreference()
        .read<String>(UserStoreKey.accessToken)
        .getOrElse((_) => '');

    return network
        .post(
          AppUrl.locationpickUrl,
          data.toModel().toJson(),
          ApiHeader.bearerHeaderWithApplicationJson(token),

          // authType: AuthType.cookie,
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
