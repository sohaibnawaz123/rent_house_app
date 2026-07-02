
import 'package:taxi_app/modules/activity/domain/params/propertydetail_param.dart';

class PropertydetailRequestModel extends PropertydetailParam {
  const PropertydetailRequestModel({
    required super.token,
    required super.propertyId,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'propertyId': propertyId,
      };
}