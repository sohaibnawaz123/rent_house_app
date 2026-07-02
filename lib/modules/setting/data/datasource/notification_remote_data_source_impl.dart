import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';

import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/setting/data/datasource/notification_remote_data_source.dart';
import 'package:taxi_app/modules/setting/data/model/response/notification_model/notification_model.dart';
import 'package:taxi_app/modules/setting/domain/params/notification_param.dart';

class NotificationRemoteDataSourceImpl
    implements NotificationRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  NotificationRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<NotificationModel>>> 
      notification(NotificationParam data) =>
      network
          .get(
            AppUrl.notificationUrl,
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
                    BaseJson<NotificationModel>.fromJson(
                      response as Map<String, dynamic>,
                      NotificationModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
