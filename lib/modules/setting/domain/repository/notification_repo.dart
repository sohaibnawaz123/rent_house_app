import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/notification_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/notification_param.dart';

abstract class NotificationRepo {
  Future<Either<RepoFailure, BaseEntity<NotificationEntity>>> 
      notification(
    NotificationParam param,
  );
}
