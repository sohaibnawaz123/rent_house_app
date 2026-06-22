import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/auth/data/model/response/register_model/user_model.dart';
import 'package:taxi_app/modules/auth/domain/entities/login_entity.dart';

class LoginModel extends Equatable {
  final UserModel? user;
  final String? accessToken;
  final String? refreshToken;

  const LoginModel({this.user, this.accessToken, this.refreshToken});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
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

  LoginModel copyWith({
    UserModel? user,
    String? accessToken,
    String? refreshToken,
  }) {
    return LoginModel(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  LoginEntity toEntity() {
    return LoginEntity(
      user: user?.toEntity(),
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  List<Object?> get props => [user, accessToken, refreshToken];
}

// class LoginModel {
//   String? userMessage;
//   bool? status;

//   LoginModel({
//     this.userMessage,
//     this.status,
//   });

//   factory LoginModel.fromJson(
//     Map<String, dynamic> json,
//   ) =>
//       LoginModel(
//         userMessage: json['userMessage'] as String?,
//         status: json['status'] as bool?,
//       );

//   Map<String, dynamic> toJson() => {
//         'userMessage': userMessage,
//         'status': status,
//       };

//   LoginEntity toEntity() {
//     return LoginEntity(
//       userMessage: userMessage ?? '',
//       status: status ?? false,
//     );
//   }
// }
