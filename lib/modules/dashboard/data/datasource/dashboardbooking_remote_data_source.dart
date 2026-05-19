import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardbooking_model/dashboardbooking_model.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardbooking_param.dart';
abstract class DashboardbookingRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<DashboardbookingModel>>> dashboardbooking(DashboardbookingParam data);

}

