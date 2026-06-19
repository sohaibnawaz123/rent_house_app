import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/activity/domain/entities/bookingreviews_entity.dart';
import 'package:taxi_app/modules/activity/domain/failures/bookingreviews_failure.dart';
import 'package:taxi_app/modules/activity/domain/params/bookingreviews_param.dart';
import 'package:taxi_app/modules/activity/domain/repository/bookingreviews_repo.dart';
import 'package:taxi_app/modules/activity/presentation/validator/bookingreviews_validator.dart';
class BookingreviewsUseCase {
  final BookingreviewsValidator validator;
  final BookingreviewsRepo _repo;

  BookingreviewsUseCase(this.validator, this._repo);

  Future<
      Either<
          BookingreviewsFailure,
          BaseEntity<BookingreviewsEntity>>> execute(
    BookingreviewsParam data,
  ) async {
    return validator
        .validate(data)
        .fold(
          (l) => left(BookingreviewsFailure(error: l.error)),
          (r) async => await _repo.bookingreviews(data).then(
          (value) => value.fold(
            (err) => left(
              BookingreviewsFailure(error: err.error),
            ),
            (response) => right(response),
          )),
        );
  }
}

