part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class ReadLocalUserEvent extends AppEvent {
  const ReadLocalUserEvent();
}

class WriteLocalUserEvent extends AppEvent {
  final LoginEntity data;

  const WriteLocalUserEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class UpdateLocalUserTokenEvent extends AppEvent {
  final String accessToken;
  final String refreshToken;

  const UpdateLocalUserTokenEvent({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];
}

class DeleteUserEvent extends AppEvent {
  const DeleteUserEvent();
}

class WriteCredentialsEvent extends AppEvent {
  final CredentialsEntity data;

  const WriteCredentialsEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class ReadCredentialsEvent extends AppEvent {
  const ReadCredentialsEvent();
}

class DeleteCredentialsEvent extends AppEvent {
  const DeleteCredentialsEvent();
}
