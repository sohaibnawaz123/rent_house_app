import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/activity/data/model/response/bookingreviews_model/bookingreviews_model.dart';
import 'package:taxi_app/modules/activity/domain/params/bookingreviews_param.dart';
abstract class BookingreviewsRemoteDataSource {
    Future<Either<RepoFailure, BaseJson<BookingreviewsModel>>> bookingreviews(BookingreviewsParam data);

}

