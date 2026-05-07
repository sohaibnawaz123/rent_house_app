import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/auth/data/model/response/signup_model/signup_model.dart';
import 'package:taxi_app/modules/auth/domain/params/signup_param.dart';
abstract class SignupRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<SignupModel>>> signup(SignupParam data);

}

