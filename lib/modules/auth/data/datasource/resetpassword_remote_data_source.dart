import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/auth/data/model/response/resetpassword_model/resetpassword_model.dart';
import 'package:taxi_app/modules/auth/domain/params/resetpassword_param.dart';
abstract class ResetpasswordRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<ResetpasswordModel>>> resetpassword(ResetpasswordParam data);

}

