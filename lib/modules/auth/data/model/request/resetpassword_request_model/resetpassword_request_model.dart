
import 'package:taxi_app/modules/auth/domain/params/resetpassword_param.dart';

class ResetpasswordRequestModel extends ResetpasswordParam {
  const ResetpasswordRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}