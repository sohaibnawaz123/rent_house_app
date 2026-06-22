import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/auth/data/model/response/register_model/user_model.dart';
import 'package:taxi_app/modules/auth/domain/entities/register_entities/register_entity.dart';

class RegisterModel extends Equatable {
  final UserModel? user;
  final String? accessToken;
  final String? refreshToken;

  const RegisterModel({this.user, this.accessToken, this.refreshToken});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  RegisterModel copyWith({
    UserModel? user,
    String? accessToken,
    String? refreshToken,
  }) {
    return RegisterModel(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  RegisterEntity toEntity() {
    return RegisterEntity(
      user: user?.toEntity(),
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  List<Object?> get props => [user, accessToken, refreshToken];
}
