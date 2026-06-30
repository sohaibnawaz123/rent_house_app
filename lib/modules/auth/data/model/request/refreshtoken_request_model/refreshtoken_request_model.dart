
import 'package:taxi_app/modules/auth/domain/params/refreshtoken_param.dart';

class RefreshtokenRequestModel extends RefreshtokenParam {
  const RefreshtokenRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}