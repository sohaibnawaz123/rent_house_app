import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/dashboard/data/model/response/dashboardprofile_model/dashboardprofile_model.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardprofile_param.dart';
abstract class DashboardprofileRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<DashboardprofileModel>>> dashboardprofile(DashboardprofileParam data);

}

