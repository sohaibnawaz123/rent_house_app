part of 'editprofile_bloc.dart';

sealed class EditprofileEvent {}

class  LoadEditprofileEvent extends EditprofileEvent {
  final EditprofileParam param;
   LoadEditprofileEvent(this.param);
}
