import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/activity/data/datasource/bookingreviews_remote_data_source.dart';
import 'package:taxi_app/modules/activity/domain/entities/bookingreviews_entity.dart';
import 'package:taxi_app/modules/activity/domain/params/bookingreviews_param.dart';
import 'package:taxi_app/modules/activity/domain/repository/bookingreviews_repo.dart';

class BookingreviewsRestApiRepo implements BookingreviewsRepo {
  final BookingreviewsRemoteDataSource _dataSource;

  BookingreviewsRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<BookingreviewsEntity>>> 
      bookingreviews(
    BookingreviewsParam param,
  ) =>
      _dataSource.bookingreviews(param).then(
        (value) => value.fold(
          (l) => left(RepoFailure(error: l.error)),
          (response) {
            try {
              return right(
                response.toDomain(
                  (val) => val!.toEntity(),
                ),
              );
            } catch (e) {
              return left(RepoFailure(error: e.toString()));
            }
          },
        ),
      );
}
