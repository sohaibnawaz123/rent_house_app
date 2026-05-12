
import 'package:taxi_app/modules/auth/domain/params/forgetpassword_param.dart';

class ForgetpasswordRequestModel extends ForgetpasswordParam {
  const ForgetpasswordRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}