import 'package:taxi_app/modules/activity/data/model/request/propertydetail_request_model/propertydetail_request_model.dart';

class PropertydetailParam {
  final String token;
  final int propertyId;

  const PropertydetailParam({
    required this.token,
    required this.propertyId,
  });

  PropertydetailRequestModel toModel() => PropertydetailRequestModel(
        token: token,
        propertyId: propertyId,
      );
}