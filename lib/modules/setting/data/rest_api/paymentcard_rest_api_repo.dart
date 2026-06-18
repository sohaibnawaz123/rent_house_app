import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/data/datasource/paymentcard_remote_data_source.dart';
import 'package:taxi_app/modules/setting/domain/entities/paymentcard_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/paymentcard_param.dart';
import 'package:taxi_app/modules/setting/domain/repository/paymentcard_repo.dart';

class PaymentcardRestApiRepo implements PaymentcardRepo {
  final PaymentcardRemoteDataSource _dataSource;

  PaymentcardRestApiRepo(this._dataSource);

  @override
  Future<Either<RepoFailure, BaseEntity<PaymentcardEntity>>> 
      paymentcard(
    PaymentcardParam param,
  ) =>
      _dataSource.paymentcard(param).then(
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
