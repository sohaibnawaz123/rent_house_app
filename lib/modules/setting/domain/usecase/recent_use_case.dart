import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/recent_entity.dart';
import 'package:taxi_app/modules/setting/domain/failures/recent_failure.dart';
import 'package:taxi_app/modules/setting/domain/params/recent_param.dart';
import 'package:taxi_app/modules/setting/domain/repository/recent_repo.dart';

class RecentUseCase {
  final RecentRepo _repo;

  RecentUseCase(this._repo);

  Future<
      Either<
          RecentFailure,
          BaseEntity<RecentEntity>>> execute(
    RecentParam data,
  ) async {
    return await _repo.recent(data).then(
          (value) => value.fold(
            (err) => left(
              RecentFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
