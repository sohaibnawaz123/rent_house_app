import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/about_entity.dart';
import 'package:taxi_app/modules/setting/domain/failures/about_failure.dart';
import 'package:taxi_app/modules/setting/domain/params/about_param.dart';
import 'package:taxi_app/modules/setting/domain/repository/about_repo.dart';

class AboutUseCase {
  final AboutRepo _repo;

  AboutUseCase(this._repo);

  Future<
      Either<
          AboutFailure,
          BaseEntity<AboutEntity>>> execute(
    AboutParam data,
  ) async {
    return await _repo.about(data).then(
          (value) => value.fold(
            (err) => left(
              AboutFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
