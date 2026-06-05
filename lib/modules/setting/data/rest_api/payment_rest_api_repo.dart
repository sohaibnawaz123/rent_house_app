import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/data/datasource/payment_remote_data_source.dart';
import 'package:taxi_app/modules/setting/domain/entities/payment_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/payment_param.dart';
import 'package:taxi_app/modules/setting/domain/repository/payment_repo.dart';

class PaymentRestApiRepo implements PaymentRepo {
  final PaymentRemoteDataSource _dataSource;

  PaymentRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<PaymentEntity>>> 
      payment(
    PaymentParam param,
  ) =>
      _dataSource.payment(param).then(
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
