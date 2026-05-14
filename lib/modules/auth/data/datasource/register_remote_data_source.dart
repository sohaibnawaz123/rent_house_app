import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/auth/data/model/response/register_model/register_model.dart';
import 'package:taxi_app/modules/auth/domain/params/register_param.dart';
abstract class RegisterRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<RegisterModel>>> register(RegisterParam data);

}

