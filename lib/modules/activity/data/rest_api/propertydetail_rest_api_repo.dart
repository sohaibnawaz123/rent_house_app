import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/activity/data/datasource/propertydetail_remote_data_source.dart';
import 'package:taxi_app/modules/activity/domain/entities/propertydetail_entity.dart';
import 'package:taxi_app/modules/activity/domain/params/propertydetail_param.dart';
import 'package:taxi_app/modules/activity/domain/repository/propertydetail_repo.dart';

class PropertydetailRestApiRepo implements PropertydetailRepo {
  final PropertydetailRemoteDataSource _dataSource;

  PropertydetailRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<PropertydetailEntity>>> 
      propertydetail(
    PropertydetailParam param,
  ) =>
      _dataSource.propertydetail(param).then(
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
