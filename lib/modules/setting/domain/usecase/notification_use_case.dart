import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/notification_entity.dart';
import 'package:taxi_app/modules/setting/domain/failures/notification_failure.dart';
import 'package:taxi_app/modules/setting/domain/params/notification_param.dart';
import 'package:taxi_app/modules/setting/domain/repository/notification_repo.dart';

class NotificationUseCase {
  final NotificationRepo _repo;

  NotificationUseCase(this._repo);

  Future<
      Either<
          NotificationFailure,
          BaseEntity<NotificationEntity>>> execute(
    NotificationParam data,
  ) async {
    return await _repo.notification(data).then(
          (value) => value.fold(
            (err) => left(
              NotificationFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
