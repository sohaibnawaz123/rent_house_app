import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/otpverification_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/otpverification_param.dart';
import 'package:taxi_app/modules/auth/domain/usecase/otpverification_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/routes/otpverification_view_initial_params.dart';

part 'otpverification_event.dart';
part 'otpverification_state.dart';

class OtpverificationBloc extends Bloc<OtpverificationEvent, OtpverificationState> {
  final OtpverificationViewInitialParams initialParams;
  final OtpverificationUseCase _useCase;

  OtpverificationBloc(this.initialParams, this._useCase)
      : super(OtpverificationState(initialParams: initialParams)) {
    on<LoadOtpverificationEvent>(_loadOtpverificationAction);
  }

  Future<void> _loadOtpverificationAction(
      LoadOtpverificationEvent event, Emitter<OtpverificationState> emit) async {
    emit(state.copyWith(otpverificationResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(otpverificationResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(otpverificationResponse: ApiResponse.completed(r)));
      },
    ));
  }
}