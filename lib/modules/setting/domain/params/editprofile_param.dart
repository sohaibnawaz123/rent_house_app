import 'package:taxi_app/modules/setting/data/model/request/editprofile_request_model/editprofile_request_model.dart';

class EditprofileParam {
  final String token;
  final String email;

  const EditprofileParam({
    required this.token,
    required this.email,
  });

  EditprofileRequestModel toModel() => EditprofileRequestModel(
        token: token,
        email: email,
      );
}