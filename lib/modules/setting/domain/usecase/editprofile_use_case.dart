import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/editprofile_entity.dart';
import 'package:taxi_app/modules/setting/domain/failures/editprofile_failure.dart';
import 'package:taxi_app/modules/setting/domain/params/editprofile_param.dart';
import 'package:taxi_app/modules/setting/domain/repository/editprofile_repo.dart';

class EditprofileUseCase {
  final EditprofileRepo _repo;

  EditprofileUseCase(this._repo);

  Future<
      Either<
          EditprofileFailure,
          BaseEntity<EditprofileEntity>>> execute(
    EditprofileParam data,
  ) async {
    return await _repo.editprofile(data).then(
          (value) => value.fold(
            (err) => left(
              EditprofileFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
