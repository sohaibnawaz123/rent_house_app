part of 'about_bloc.dart';

sealed class AboutEvent {}

class  LoadAboutEvent extends AboutEvent {
  final AboutParam param;
   LoadAboutEvent(this.param);
}
