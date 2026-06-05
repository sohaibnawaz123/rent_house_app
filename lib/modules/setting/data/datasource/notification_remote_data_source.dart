import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/setting/data/model/response/notification_model/notification_model.dart';
import 'package:taxi_app/modules/setting/domain/params/notification_param.dart';
abstract class NotificationRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<NotificationModel>>> notification(NotificationParam data);

}

