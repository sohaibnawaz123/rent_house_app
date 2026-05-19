import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardfavourite_model/dashboardfavourite_model.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardfavourite_param.dart';
abstract class DashboardfavouriteRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<DashboardfavouriteModel>>> dashboardfavourite(DashboardfavouriteParam data);

}

