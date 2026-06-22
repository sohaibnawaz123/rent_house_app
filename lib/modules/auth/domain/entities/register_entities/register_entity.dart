import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/auth/domain/entities/register_entities/user_entity.dart';

class RegisterEntity extends Equatable {
  final UserEntity? user;
  final String? accessToken;
  final String? refreshToken;

  const RegisterEntity({this.user, this.accessToken, this.refreshToken});

  @override
  List<Object?> get props => [user, accessToken, refreshToken];
}
// class RegisterEntity {
//   final String userMessage;
//   final bool status;

//   RegisterEntity({
//     required this.userMessage,
//     required this.status,
//   });

//   RegisterEntity copyWith({
//     String? userMessage,
//     bool? status,
//   }) {
//     return RegisterEntity(
//       userMessage: userMessage ?? this.userMessage,
//       status: status ?? this.status,
//     );
//   }
// }
