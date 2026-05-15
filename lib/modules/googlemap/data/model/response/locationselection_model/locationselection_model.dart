import 'package:taxi_app/modules/googlemap/domain/entities/locationselection_entity.dart';

class LocationselectionModel {
  String? userMessage;
  bool? status;

  LocationselectionModel({
    this.userMessage,
    this.status,
  });

  factory LocationselectionModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      LocationselectionModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  LocationselectionEntity toEntity() {
    return LocationselectionEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
