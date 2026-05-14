part of 'register_bloc.dart';

sealed class RegisterEvent {}

class  LoadRegisterEvent extends RegisterEvent {
  final RegisterParam param;
   LoadRegisterEvent(this.param);
}
