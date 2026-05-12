part of 'forgetpassword_bloc.dart';

sealed class ForgetpasswordEvent {}

class  LoadForgetpasswordEvent extends ForgetpasswordEvent {
  final ForgetpasswordParam param;
   LoadForgetpasswordEvent(this.param);
}
