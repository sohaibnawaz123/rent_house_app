import 'package:taxi_app/modules/setting/data/model/request/about_request_model/about_request_model.dart';

class AboutParam {
  final String token;
  final String email;

  const AboutParam({
    required this.token,
    required this.email,
  });

  AboutRequestModel toModel() => AboutRequestModel(
        token: token,
        email: email,
      );
}