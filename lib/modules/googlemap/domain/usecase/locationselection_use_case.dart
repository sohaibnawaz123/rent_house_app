import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/entities/locationselection_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/failures/locationselection_failure.dart';
import 'package:taxi_app/modules/googlemap/domain/params/locationselection_param.dart';
import 'package:taxi_app/modules/googlemap/domain/repository/locationselection_repo.dart';

class LocationselectionUseCase {
  final LocationselectionRepo _repo;

  LocationselectionUseCase(this._repo);

  Future<
      Either<
          LocationselectionFailure,
          BaseEntity<LocationselectionEntity>>> execute(
    LocationselectionParam data,
  ) async {
    return await _repo.locationselection(data).then(
          (value) => value.fold(
            (err) => left(
              LocationselectionFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
