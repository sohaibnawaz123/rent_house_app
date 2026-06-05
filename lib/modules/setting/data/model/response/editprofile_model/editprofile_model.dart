import 'package:taxi_app/modules/setting/domain/entities/editprofile_entity.dart';

class EditprofileModel {
  String? userMessage;
  bool? status;

  EditprofileModel({
    this.userMessage,
    this.status,
  });

  factory EditprofileModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      EditprofileModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  EditprofileEntity toEntity() {
    return EditprofileEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
