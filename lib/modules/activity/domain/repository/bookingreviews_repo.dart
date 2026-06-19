import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/activity/domain/entities/bookingreviews_entity.dart';
import 'package:taxi_app/modules/activity/domain/params/bookingreviews_param.dart';

abstract class BookingreviewsRepo {
  Future<Either<RepoFailure, BaseEntity<BookingreviewsEntity>>> 
      bookingreviews(
    BookingreviewsParam param,
  );
}
