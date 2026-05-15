import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/googlemap/data/model/response/locationpick_model/locationpick_model.dart';
import 'package:taxi_app/modules/googlemap/domain/params/locationpick_param.dart';
abstract class LocationpickRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<LocationpickModel>>> locationpick(LocationpickParam data);

}

