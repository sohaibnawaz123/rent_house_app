part of 'login_bloc.dart';

sealed class LoginEvent {}

class  LoadLoginEvent extends LoginEvent {
  final LoginParam param;
   LoadLoginEvent(this.param);
}

class LoadLogoutEvent extends LoginEvent {
  final String accessToken;

  LoadLogoutEvent(this.accessToken);
}
