import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/activity/domain/entities/propertydetail_entity.dart';
import 'package:taxi_app/modules/activity/domain/params/propertydetail_param.dart';

abstract class PropertydetailRepo {
  Future<Either<RepoFailure, BaseEntity<PropertydetailEntity>>> 
      propertydetail(
    PropertydetailParam param,
  );
}
