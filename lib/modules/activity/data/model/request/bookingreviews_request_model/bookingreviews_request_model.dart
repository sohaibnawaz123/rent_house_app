
import 'package:taxi_app/modules/activity/domain/params/bookingreviews_param.dart';

class BookingreviewsRequestModel extends BookingreviewsParam {
  const BookingreviewsRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}