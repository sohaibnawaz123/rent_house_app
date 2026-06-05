import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/recent_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/recent_param.dart';

abstract class RecentRepo {
  Future<Either<RepoFailure, BaseEntity<RecentEntity>>> 
      recent(
    RecentParam param,
  );
}
