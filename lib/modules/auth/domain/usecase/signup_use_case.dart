import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/signup_entity.dart';
import 'package:taxi_app/modules/auth/domain/failures/signup_failure.dart';
import 'package:taxi_app/modules/auth/domain/params/signup_param.dart';
import 'package:taxi_app/modules/auth/domain/repository/signup_repo.dart';

class SignupUseCase {
  final SignupRepo _repo;

  SignupUseCase(this._repo);

  Future<
      Either<
          SignupFailure,
          BaseEntity<SignupEntity>>> execute(
    SignupParam data,
  ) async {
    return await _repo.signup(data).then(
          (value) => value.fold(
            (err) => left(
              SignupFailure(error: err.error),
            ),
            (response) => right(response),
          ),
        );
  }
}
