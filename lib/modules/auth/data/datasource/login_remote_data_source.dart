import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/auth/data/model/response/login_model/login_model.dart';
import 'package:taxi_app/modules/auth/domain/params/login_param.dart';
abstract class LoginRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<LoginModel>>> login(LoginParam data);

}

