import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/setting/data/model/response/about_model/about_model.dart';
import 'package:taxi_app/modules/setting/domain/params/about_param.dart';
abstract class AboutRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<AboutModel>>> about(AboutParam data);

}

