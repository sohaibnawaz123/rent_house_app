import 'package:taxi_app/modules/auth/domain/params/refreshtoken_param.dart';

class RefreshtokenRequestModel extends RefreshtokenParam {
  const RefreshtokenRequestModel({
    required super.token,
  });

  Map<String, dynamic> toJson() => {
        'refresh_token': token,
      };
}
