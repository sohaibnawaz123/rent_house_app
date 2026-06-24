import 'package:equatable/equatable.dart';

class AgentEntity extends Equatable {
  final int id;
  final String username;
  final String email;

  const AgentEntity({
    required this.id,
    required this.username,
    required this.email,
  });

  @override
  List<Object?> get props => [id, username, email];
}
