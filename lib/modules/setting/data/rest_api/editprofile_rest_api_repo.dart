import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/data/datasource/editprofile_remote_data_source.dart';
import 'package:taxi_app/modules/setting/domain/entities/editprofile_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/editprofile_param.dart';
import 'package:taxi_app/modules/setting/domain/repository/editprofile_repo.dart';

class EditprofileRestApiRepo implements EditprofileRepo {
  final EditprofileRemoteDataSource _dataSource;

  EditprofileRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<EditprofileEntity>>> 
      editprofile(
    EditprofileParam param,
  ) =>
      _dataSource.editprofile(param).then(
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
