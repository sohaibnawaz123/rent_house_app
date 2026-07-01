import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/validation_failure.dart';
import 'package:taxi_app/modules/auth/domain/params/refreshtoken_param.dart';

class RefreshtokenValidator {
  Either<ValidationFailure, RefreshtokenParam> validate(RefreshtokenParam data) {
    if (data.token.trim().isEmpty) {
      return left(ValidationFailure(error: 'Refresh token is required'));
    }

    return right(data);
  }
}
