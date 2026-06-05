import 'package:taxi_app/modules/setting/domain/entities/about_entity.dart';

class AboutModel {
  String? userMessage;
  bool? status;

  AboutModel({
    this.userMessage,
    this.status,
  });

  factory AboutModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      AboutModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  AboutEntity toEntity() {
    return AboutEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
