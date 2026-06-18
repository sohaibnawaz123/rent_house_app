import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/activity/data/model/response/reserve_model/reserve_model.dart';
import 'package:taxi_app/modules/activity/domain/params/reserve_param.dart';
abstract class ReserveRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<ReserveModel>>> reserve(ReserveParam data);

}

