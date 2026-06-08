import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/activity/data/model/response/propertydetail_model/propertydetail_model.dart';
import 'package:taxi_app/modules/activity/domain/params/propertydetail_param.dart';
abstract class PropertydetailRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<PropertydetailModel>>> propertydetail(PropertydetailParam data);

}

