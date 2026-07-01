import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/auth/data/model/response/logout_model/logout_model.dart';
import 'package:taxi_app/modules/auth/domain/params/logout_param.dart';

abstract class LogoutRemoteDataSource {
  Future<Either<RepoFailure, LogoutModel>> logout(LogoutParam data);
}
