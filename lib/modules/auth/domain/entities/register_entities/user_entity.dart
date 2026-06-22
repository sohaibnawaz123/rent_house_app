import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
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

  const UserEntity({
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
