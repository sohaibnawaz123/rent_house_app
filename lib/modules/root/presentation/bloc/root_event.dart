part of 'root_bloc.dart';

sealed class RootEvent {}

class OnPageChangeEvent extends RootEvent {
  final int index;
  OnPageChangeEvent(this.index);
}
