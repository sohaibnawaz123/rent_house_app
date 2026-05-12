import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/resetpassword_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/resetpassword_param.dart';
import 'package:taxi_app/modules/auth/domain/usecase/resetpassword_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/routes/resetpassword_view_initial_params.dart';

part 'resetpassword_event.dart';
part 'resetpassword_state.dart';

class ResetpasswordBloc extends Bloc<ResetpasswordEvent, ResetpasswordState> {
  final ResetpasswordViewInitialParams initialParams;
  final ResetpasswordUseCase _useCase;

  ResetpasswordBloc(this.initialParams, this._useCase)
      : super(ResetpasswordState(initialParams: initialParams)) {
    on<LoadResetpasswordEvent>(_loadResetpasswordAction);
  }

  Future<void> _loadResetpasswordAction(
      LoadResetpasswordEvent event, Emitter<ResetpasswordState> emit) async {
    emit(state.copyWith(resetpasswordResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(resetpasswordResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(resetpasswordResponse: ApiResponse.completed(r)));
      },
    ));
  }
}