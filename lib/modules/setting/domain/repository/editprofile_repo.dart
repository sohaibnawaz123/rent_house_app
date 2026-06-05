import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/editprofile_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/editprofile_param.dart';

abstract class EditprofileRepo {
  Future<Either<RepoFailure, BaseEntity<EditprofileEntity>>> 
      editprofile(
    EditprofileParam param,
  );
}
