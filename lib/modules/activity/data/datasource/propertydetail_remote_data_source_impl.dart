import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/activity/data/datasource/propertydetail_remote_data_source.dart';
import 'package:taxi_app/modules/activity/data/model/response/propertydetail_model/propertydetail_model.dart';
import 'package:taxi_app/modules/activity/domain/params/propertydetail_param.dart';

class PropertydetailRemoteDataSourceImpl
    implements PropertydetailRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  PropertydetailRemoteDataSourceImpl(this.network, this.appUrl);

  @override
  Future<Either<RepoFailure, BaseJson<PropertydetailModel>>> propertydetail(
    PropertydetailParam data,
  ) => network
      .get(
        AppUrl.propertydetailUrl,
        ApiHeader.bearerHeaderOnly(data.token),
        query: {"propertyId":data.propertyId},
        // authType: AuthType.cookie,
      )
      .then(
        (value) =>
            value.fold((l) => left(RepoFailure(error: l.error)), (response) {
              try {
                  return right(
                    BaseJson<PropertydetailModel>.fromJson(
                    response as Map<String, dynamic>,
                    PropertydetailModel.fromJson,
                  ),
                );
              } catch (e) {
                return left(RepoFailure(error: e.toString()));
              }
            }),
      );
}
