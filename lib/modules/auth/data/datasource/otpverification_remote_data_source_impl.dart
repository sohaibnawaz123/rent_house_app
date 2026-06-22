import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/core/network/network_service.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/auth/data/datasource/otpverification_remote_data_source.dart';
import 'package:taxi_app/modules/auth/data/model/response/otpverification_model/otpverification_model.dart';
import 'package:taxi_app/modules/auth/domain/params/otpverification_param.dart';

class OtpverificationRemoteDataSourceImpl
    implements OtpverificationRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  OtpverificationRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<OtpverificationModel>>> 
      otpverification(OtpverificationParam data) =>
      network
          .post(
            AppUrl.otpverificationUrl,
             data.toModel().toJson(),
            ApiHeader.json(),
        // authType: AuthType.cookie,

          )
          .then(
            (value) => value.fold(
              (l) => left(RepoFailure(error: l.error)),
              (response) {
                try {
                  return right(
                    BaseJson<OtpverificationModel>.fromJson(
                      response as Map<String, dynamic>,
                      OtpverificationModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
