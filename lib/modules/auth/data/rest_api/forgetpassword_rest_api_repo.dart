import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/data/datasource/forgetpassword_remote_data_source.dart';
import 'package:taxi_app/modules/auth/domain/entities/forgetpassword_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/forgetpassword_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/forgetpassword_repo.dart';

class ForgetpasswordRestApiRepo implements ForgetpasswordRepo {
  final ForgetpasswordRemoteDataSource _dataSource;

  ForgetpasswordRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<ForgetpasswordEntity>>> 
      forgetpassword(
    ForgetpasswordParam param,
  ) =>
      _dataSource.forgetpassword(param).then(
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
