import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/setting/data/datasource/editprofile_remote_data_source.dart';
import 'package:taxi_app/modules/setting/data/model/response/editprofile_model/editprofile_model.dart';
import 'package:taxi_app/modules/setting/domain/params/editprofile_param.dart';

class EditprofileRemoteDataSourceImpl
    implements EditprofileRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  EditprofileRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<EditprofileModel>>> 
      editprofile(EditprofileParam data) =>
      network
          .get(
            AppUrl.editprofileUrl,
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
                    BaseJson<EditprofileModel>.fromJson(
                      response.data,
                          EditprofileModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
