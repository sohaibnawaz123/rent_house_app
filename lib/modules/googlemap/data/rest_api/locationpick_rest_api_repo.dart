import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/googlemap/data/datasource/locationpick_remote_data_source.dart';
import 'package:taxi_app/modules/googlemap/domain/entities/locationpick_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/params/locationpick_param.dart';
import 'package:taxi_app/modules/googlemap/domain/repository/locationpick_repo.dart';

class LocationpickRestApiRepo implements LocationpickRepo {
  final LocationpickRemoteDataSource _dataSource;

  LocationpickRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<LocationpickEntity>>> 
      locationpick(
    LocationpickParam param,
  ) =>
      _dataSource.locationpick(param).then(
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
