import 'package:taxi_app/modules/googlemap/domain/entities/locationpick_entity.dart';

class LocationpickModel {
  String? userMessage;
  bool? status;

  LocationpickModel({
    this.userMessage,
    this.status,
  });

  factory LocationpickModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      LocationpickModel(
        userMessage: json['userMessage'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userMessage': userMessage,
        'status': status,
      };

  LocationpickEntity toEntity() {
    return LocationpickEntity(
      userMessage: userMessage ?? '',
      status: status ?? false,
    );
  }
}
