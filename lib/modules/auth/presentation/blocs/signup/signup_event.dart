part of 'signup_bloc.dart';

sealed class SignupEvent {}

class  LoadSignupEvent extends SignupEvent {
  final SignupParam param;
   LoadSignupEvent(this.param);
}
