import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardroot_model/dashboardroot_model.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardroot_param.dart';
abstract class DashboardrootRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<DashboardrootModel>>> dashboardroot(DashboardrootParam data);

}

