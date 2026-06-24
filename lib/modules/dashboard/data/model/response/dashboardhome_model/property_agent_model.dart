import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/property_agent_entity.dart';

class AgentModel extends Equatable {
  final int? id;
  final String? username;
  final String? email;

  const AgentModel({this.id, this.username, this.email});

  factory AgentModel.fromJson(Map<String, dynamic> json) {
    return AgentModel(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'email': email};
  }

  AgentModel copyWith({int? id, String? username, String? email}) {
    return AgentModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  AgentEntity toEntity() {
    return AgentEntity(
      id: id ?? 0,
      username: username ?? '',
      email: email ?? '',
    );
  }

  @override
  List<Object?> get props => [id, username, email];
}
