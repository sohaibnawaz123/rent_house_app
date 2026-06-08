import 'package:taxi_app/modules/activity/domain/entities/propertydetail_entity.dart';

class PropertydetailModel {
  String? userMessage;
  bool? status;

  PropertydetailModel({
    this.userMessage,
    this.status,
  });

  factory PropertydetailModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      PropertydetailModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  PropertydetailEntity toEntity() {
    return PropertydetailEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
