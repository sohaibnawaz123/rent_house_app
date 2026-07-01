import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/auth/domain/entities/logout_entity.dart';

class LogoutModel extends Equatable {
  final String? message;

  const LogoutModel({this.message});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(message: json['message'] as String?);
  }

  LogoutEntity toEntity() {
    return LogoutEntity(message: message ?? '');
  }

  @override
  List<Object?> get props => [message];
}
