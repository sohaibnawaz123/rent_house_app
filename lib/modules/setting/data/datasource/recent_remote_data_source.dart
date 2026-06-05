import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/setting/data/model/response/recent_model/recent_model.dart';
import 'package:taxi_app/modules/setting/domain/params/recent_param.dart';
abstract class RecentRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<RecentModel>>> recent(RecentParam data);

}

