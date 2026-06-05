import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/notification_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/notification_param.dart';
import 'package:taxi_app/modules/setting/domain/usecase/notification_use_case.dart';
import 'package:taxi_app/modules/setting/presentation/routes/notification_view_initial_params.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationViewInitialParams initialParams;
  final NotificationUseCase _useCase;

  NotificationBloc(this.initialParams, this._useCase)
      : super(NotificationState(initialParams: initialParams)) {
    on<LoadNotificationEvent>(_loadNotificationAction);
  }

  Future<void> _loadNotificationAction(
      LoadNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(notificationResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(notificationResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(notificationResponse: ApiResponse.completed(r)));
      },
    ));
  }
}