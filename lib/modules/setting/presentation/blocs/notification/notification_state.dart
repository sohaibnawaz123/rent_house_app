part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final NotificationViewInitialParams initialParams;
  final ApiResponse<BaseEntity<NotificationEntity>> notificationResponse;

  const NotificationState({
    required this.initialParams,
    this.notificationResponse = const ApiResponse.init(),
  });

   NotificationState copyWith({
    NotificationViewInitialParams? initialParams,
    ApiResponse<BaseEntity<NotificationEntity>>? notificationResponse,
  }) {
    NotificationState data =   NotificationState(
      initialParams: initialParams ?? this.initialParams,
      notificationResponse: notificationResponse ?? this.notificationResponse,
    );
    Utils.logInfo(data.toString(), name: "Notification");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, notificationResponse];

  @override
  String toString() {
    return 'NotificationState(initialParams: $initialParams, notificationResponse: ${notificationResponse.toString()})';
  }
}
