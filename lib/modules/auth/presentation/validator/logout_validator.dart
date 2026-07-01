import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/validation_failure.dart';
import 'package:taxi_app/modules/auth/domain/params/logout_param.dart';

class LogoutValidator {
  Either<ValidationFailure, LogoutParam> validate(LogoutParam data) {
    if (data.accessToken.trim().isEmpty) {
      return left(ValidationFailure(error: 'Access token is required'));
    }

    return right(data);
  }
}
