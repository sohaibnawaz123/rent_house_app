import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/data/datasource/about_remote_data_source.dart';
import 'package:taxi_app/modules/setting/domain/entities/about_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/about_param.dart';
import 'package:taxi_app/modules/setting/domain/repository/about_repo.dart';

class AboutRestApiRepo implements AboutRepo {
  final AboutRemoteDataSource _dataSource;

  AboutRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<AboutEntity>>> 
      about(
    AboutParam param,
  ) =>
      _dataSource.about(param).then(
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
