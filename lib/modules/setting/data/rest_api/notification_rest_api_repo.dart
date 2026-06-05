import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/data/datasource/notification_remote_data_source.dart';
import 'package:taxi_app/modules/setting/domain/entities/notification_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/notification_param.dart';
import 'package:taxi_app/modules/setting/domain/repository/notification_repo.dart';

class NotificationRestApiRepo implements NotificationRepo {
  final NotificationRemoteDataSource _dataSource;

  NotificationRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<NotificationEntity>>> 
      notification(
    NotificationParam param,
  ) =>
      _dataSource.notification(param).then(
        (value) => value.fold(
          (l) => left(RepoFailure(error: l.error)),
          (response) {
            try {
              return right(
                response.toDomain(
                  (val) => val!.toEntity(),
                ),
              );
            } catch (e) {
              return left(RepoFailure(error: e.toString()));
            }
          },
        ),
      );
}
