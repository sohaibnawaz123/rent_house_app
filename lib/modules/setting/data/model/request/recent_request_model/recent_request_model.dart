
import 'package:taxi_app/modules/setting/domain/params/recent_param.dart';

class RecentRequestModel extends RecentParam {
  const RecentRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}