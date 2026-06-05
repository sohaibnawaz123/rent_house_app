import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/about_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/about_param.dart';

abstract class AboutRepo {
  Future<Either<RepoFailure, BaseEntity<AboutEntity>>> 
      about(
    AboutParam param,
  );
}
