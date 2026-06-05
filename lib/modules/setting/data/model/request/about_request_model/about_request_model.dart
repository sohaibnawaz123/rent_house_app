
import 'package:taxi_app/modules/setting/domain/params/about_param.dart';

class AboutRequestModel extends AboutParam {
  const AboutRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}