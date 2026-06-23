import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/auth/domain/entities/register_entities/user_entity.dart'
    as auth;

class AppUserEntity extends Equatable {
  final bool? emailVerified;
  final int? id;
  final String? username;
  final int? roleId;
  final String? email;
  final String? updatedAt;
  final String? createdAt;

  const AppUserEntity({
    this.emailVerified,
    this.id,
    this.username,
    this.roleId,
    this.email,
    this.updatedAt,
    this.createdAt,
  });

  const AppUserEntity.empty()
    : emailVerified = null,
      id = null,
      username = null,
      roleId = null,
      email = null,
      updatedAt = null,
      createdAt = null;

  factory AppUserEntity.fromAuthUser(auth.UserEntity? user) {
    if (user == null) return const AppUserEntity.empty();

    return AppUserEntity(
      emailVerified: user.emailVerified,
      id: user.id,
      username: user.username,
      roleId: user.roleId,
      email: user.email,
      updatedAt: user.updatedAt,
      createdAt: user.createdAt,
    );
  }

  factory AppUserEntity.fromJson(Map<String, dynamic> json) {
    return AppUserEntity(
      emailVerified: json['email_verified'] as bool?,
      id: json['id'] as int?,
      username: json['username'] as String?,
      roleId: json['role_id'] as int?,
      email: json['email'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email_verified': emailVerified,
      'id': id,
      'username': username,
      'role_id': roleId,
      'email': email,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  @override
  List<Object?> get props => [
    emailVerified,
    id,
    username,
    roleId,
    email,
    updatedAt,
    createdAt,
  ];
}

class CredentialsEntity extends Equatable {
  final String email;
  final String password;

  const CredentialsEntity({required this.email, required this.password});

  const CredentialsEntity.empty() : email = '', password = '';

  factory CredentialsEntity.fromJson(Map<String, dynamic> json) {
    return CredentialsEntity(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  bool get isEmpty => email.isEmpty && password.isEmpty;

  @override
  List<Object?> get props => [email, password];
}
