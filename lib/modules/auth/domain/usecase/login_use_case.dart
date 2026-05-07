import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/login_entity.dart';
import 'package:taxi_app/modules/auth/domain/failures/login_failure.dart';
import 'package:taxi_app/modules/auth/domain/params/login_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/login_repo.dart';

class LoginUseCase {
  final LoginRepo _repo;

  LoginUseCase(this._repo);

  Future<
      Either<
          LoginFailure,
          BaseEntity<LoginEntity>>> execute(
    LoginParam data,
  ) async {
    return await _repo.login(data).then(
          (value) => value.fold(
            (err) => left(
              LoginFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
