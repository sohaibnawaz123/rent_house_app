part of 'bookingreviews_bloc.dart';

sealed class BookingreviewsEvent {}

class  LoadBookingreviewsEvent extends BookingreviewsEvent {
  final BookingreviewsParam param;
   LoadBookingreviewsEvent(this.param);
}
