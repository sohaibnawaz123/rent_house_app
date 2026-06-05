part of 'notification_bloc.dart';

sealed class NotificationEvent {}

class  LoadNotificationEvent extends NotificationEvent {
  final NotificationParam param;
   LoadNotificationEvent(this.param);
}
