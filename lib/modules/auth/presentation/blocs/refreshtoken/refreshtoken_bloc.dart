import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/refreshtoken_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/refreshtoken_param.dart';
import 'package:taxi_app/modules/auth/domain/usecase/refreshtoken_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/routes/refreshtoken_view_initial_params.dart';

part 'refreshtoken_event.dart';
part 'refreshtoken_state.dart';

class RefreshtokenBloc extends Bloc<RefreshtokenEvent, RefreshtokenState> {
  final RefreshtokenViewInitialParams initialParams;
  final RefreshtokenUseCase _useCase;

  RefreshtokenBloc(this.initialParams, this._useCase)
      : super(RefreshtokenState(initialParams: initialParams)) {
    on<LoadRefreshtokenEvent>(_loadRefreshtokenAction);
  }

  Future<void> _loadRefreshtokenAction(
      LoadRefreshtokenEvent event, Emitter<RefreshtokenState> emit) async {
    emit(state.copyWith(refreshtokenResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(refreshtokenResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(refreshtokenResponse: ApiResponse.completed(r)));
      },
    ));
  }
}