import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardexplore_model/dashboardexplore_model.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardexplore_param.dart';
abstract class DashboardexploreRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<DashboardexploreModel>>> dashboardexplore(DashboardexploreParam data);

}

