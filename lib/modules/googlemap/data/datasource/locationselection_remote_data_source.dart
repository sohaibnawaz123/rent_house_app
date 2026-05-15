import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/googlemap/data/model/response/locationselection_model/locationselection_model.dart';
import 'package:taxi_app/modules/googlemap/domain/params/locationselection_param.dart';
abstract class LocationselectionRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<LocationselectionModel>>> locationselection(LocationselectionParam data);

}

