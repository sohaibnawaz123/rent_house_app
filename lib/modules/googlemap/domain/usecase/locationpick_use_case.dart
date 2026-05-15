import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/entities/locationpick_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/failures/locationpick_failure.dart';
import 'package:taxi_app/modules/googlemap/domain/params/locationpick_param.dart';
import 'package:taxi_app/modules/googlemap/domain/repository/locationpick_repo.dart';

class LocationpickUseCase {
  final LocationpickRepo _repo;

  LocationpickUseCase(this._repo);

  Future<
      Either<
          LocationpickFailure,
          BaseEntity<LocationpickEntity>>> execute(
    LocationpickParam data,
  ) async {
    return await _repo.locationpick(data).then(
          (value) => value.fold(
            (err) => left(
              LocationpickFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
