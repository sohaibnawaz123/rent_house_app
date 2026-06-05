
import 'package:taxi_app/modules/setting/domain/params/editprofile_param.dart';

class EditprofileRequestModel extends EditprofileParam {
  const EditprofileRequestModel({
    required super.token,
    required super.email,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
      };
}