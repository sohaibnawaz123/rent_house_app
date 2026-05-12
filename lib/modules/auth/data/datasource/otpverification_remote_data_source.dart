import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/auth/data/model/response/otpverification_model/otpverification_model.dart';
import 'package:taxi_app/modules/auth/domain/params/otpverification_param.dart';
abstract class OtpverificationRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<OtpverificationModel>>> otpverification(OtpverificationParam data);

}

