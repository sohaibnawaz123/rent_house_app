part of 'resetpassword_bloc.dart';

sealed class ResetpasswordEvent {}

class  LoadResetpasswordEvent extends ResetpasswordEvent {
  final ResetpasswordParam param;
   LoadResetpasswordEvent(this.param);
}
