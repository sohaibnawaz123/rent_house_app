part of 'propertydetail_bloc.dart';

sealed class PropertydetailEvent {}

class  LoadPropertydetailEvent extends PropertydetailEvent {
  final PropertydetailParam param;
   LoadPropertydetailEvent(this.param);
}
