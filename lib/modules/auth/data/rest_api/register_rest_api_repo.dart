import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/data/datasource/register_remote_data_source.dart';
import 'package:taxi_app/modules/auth/domain/entities/register_entities/register_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/register_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/register_repo.dart';

class RegisterRestApiRepo implements RegisterRepo {
  final RegisterRemoteDataSource _dataSource;

  RegisterRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<RegisterEntity>>> 
      register(
    RegisterParam param,
  ) =>
      _dataSource.register(param).then(
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
