import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/auth/domain/entities/register_entities/user_entity.dart';

class UserModel extends Equatable {
  final bool? emailVerified;
  final int? id;
  final String? username;
  final String? password;
  final int? roleId;
  final String? email;
  final String? emailVerificationToken;
  final String? emailVerificationExpires;
  final String? updatedAt;
  final String? createdAt;

  const UserModel({
    this.emailVerified,
    this.id,
    this.username,
    this.password,
    this.roleId,
    this.email,
    this.emailVerificationToken,
    this.emailVerificationExpires,
    this.updatedAt,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      emailVerified: json['email_verified'],
      id: json['id'],
      username: json['username'],
      password: json['password'],
      roleId: json['role_id'],
      email: json['email'],
      emailVerificationToken: json['email_verification_token'],
      emailVerificationExpires: json['email_verification_expires'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email_verified': emailVerified,
      'id': id,
      'username': username,
      'password': password,
      'role_id': roleId,
      'email': email,
      'email_verification_token': emailVerificationToken,
      'email_verification_expires': emailVerificationExpires,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  UserModel copyWith({
    bool? emailVerified,
    int? id,
    String? username,
    String? password,
    int? roleId,
    String? email,
    String? emailVerificationToken,
    String? emailVerificationExpires,
    String? updatedAt,
    String? createdAt,
  }) {
    return UserModel(
      emailVerified: emailVerified ?? this.emailVerified,
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      roleId: roleId ?? this.roleId,
      email: email ?? this.email,
      emailVerificationToken:
          emailVerificationToken ?? this.emailVerificationToken,
      emailVerificationExpires:
          emailVerificationExpires ?? this.emailVerificationExpires,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      emailVerified: emailVerified,
      id: id,
      username: username,
      password: password,
      roleId: roleId,
      email: email,
      emailVerificationToken: emailVerificationToken,
      emailVerificationExpires: emailVerificationExpires,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [
    emailVerified,
    id,
    username,
    password,
    roleId,
    email,
    emailVerificationToken,
    emailVerificationExpires,
    updatedAt,
    createdAt,
  ];
}
