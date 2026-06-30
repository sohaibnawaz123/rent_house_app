import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/auth/data/model/response/refreshtoken_model/refreshtoken_model.dart';
import 'package:taxi_app/modules/auth/domain/params/refreshtoken_param.dart';
abstract class RefreshtokenRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<RefreshtokenModel>>> refreshtoken(RefreshtokenParam data);

}

