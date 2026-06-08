import 'package:taxi_app/modules/activity/data/model/request/propertydetail_request_model/propertydetail_request_model.dart';

class PropertydetailParam {
  final String token;
  final String email;

  const PropertydetailParam({
    required this.token,
    required this.email,
  });

  PropertydetailRequestModel toModel() => PropertydetailRequestModel(
        token: token,
        email: email,
      );
}