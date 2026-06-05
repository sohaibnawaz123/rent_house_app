import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/setting/data/model/response/editprofile_model/editprofile_model.dart';
import 'package:taxi_app/modules/setting/domain/params/editprofile_param.dart';
abstract class EditprofileRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<EditprofileModel>>> editprofile(EditprofileParam data);

}

