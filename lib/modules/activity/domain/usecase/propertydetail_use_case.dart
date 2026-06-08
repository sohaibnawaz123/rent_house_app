import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/activity/domain/entities/propertydetail_entity.dart';
import 'package:taxi_app/modules/activity/domain/failures/propertydetail_failure.dart';
import 'package:taxi_app/modules/activity/domain/params/propertydetail_param.dart';
import 'package:taxi_app/modules/activity/domain/repository/propertydetail_repo.dart';

class PropertydetailUseCase {
  final PropertydetailRepo _repo;

  PropertydetailUseCase(this._repo);

  Future<
      Either<
          PropertydetailFailure,
          BaseEntity<PropertydetailEntity>>> execute(
    PropertydetailParam data,
  ) async {
    return await _repo.propertydetail(data).then(
          (value) => value.fold(
            (err) => left(
              PropertydetailFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
