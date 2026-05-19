import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardhome_model/dashboardhome_model.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardhome_param.dart';
abstract class DashboardhomeRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<DashboardhomeModel>>> dashboardhome(DashboardhomeParam data);

}

