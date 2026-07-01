import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/auth/domain/entities/refreshtoken_entity.dart';

class RefreshtokenModel extends Equatable {
  final String? message;
  final String? accessToken;
  final String? refreshToken;

  const RefreshtokenModel({this.message, this.accessToken, this.refreshToken});

  factory RefreshtokenModel.fromJson(Map<String, dynamic> json) {
    return RefreshtokenModel(
      message: json['message'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  RefreshtokenModel copyWith({
    String? message,
    String? accessToken,
    String? refreshToken,
  }) {
    return RefreshtokenModel(
      message: message ?? this.message,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  RefreshtokenEntity toEntity() {
    return RefreshtokenEntity(
      message: message ?? '',
      accessToken: accessToken ?? '',
      refreshToken: refreshToken ?? '',
    );
  }

  @override
  List<Object?> get props => [message, accessToken, refreshToken];
}

// class RefreshtokenModel {
//   String? userMessage;
//   bool? status;

//   RefreshtokenModel({
//     this.userMessage,
//     this.status,
//   });

//   factory RefreshtokenModel.fromJson(
//     Map<String, dynamic> json,
//   ) =>
//       RefreshtokenModel(
//         userMessage: json['userMessage'] as String?,
//         status: json['status'] as bool?,
//       );

//   Map<String, dynamic> toJson() => {
//         'userMessage': userMessage,
//         'status': status,
//       };

//   RefreshtokenEntity toEntity() {
//     return RefreshtokenEntity(
//        message: message ??'', accessToken: '', refreshToken: '',
//     );
//   }
// }
