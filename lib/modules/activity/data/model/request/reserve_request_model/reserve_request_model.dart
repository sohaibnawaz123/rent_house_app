
import 'package:taxi_app/modules/activity/domain/params/reserve_param.dart';

class ReserveRequestModel extends ReserveParam {
  const ReserveRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}