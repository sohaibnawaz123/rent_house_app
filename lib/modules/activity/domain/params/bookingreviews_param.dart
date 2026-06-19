import 'package:taxi_app/modules/activity/data/model/request/bookingreviews_request_model/bookingreviews_request_model.dart';

class BookingreviewsParam {
  final String token;
  final String email;

  const BookingreviewsParam({
    required this.token,
    required this.email,
  });

  BookingreviewsRequestModel toModel() => BookingreviewsRequestModel(
        token: token,
        email: email,
      );
}