import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/validation_failure.dart';
import 'package:taxi_app/core/validator/validator.dart';
import 'package:taxi_app/modules/activity/domain/params/reserve_param.dart';


class ReserveValidator {
  Either<ValidationFailure, ReserveParam> validate(ReserveParam data) {
    if (Validator.validateEmail(data.email) != null) {
      return left(
        ValidationFailure(error: Validator.validateEmail(data.email)!),
      );
    }  else {
      return right(data);
    }
  }
}