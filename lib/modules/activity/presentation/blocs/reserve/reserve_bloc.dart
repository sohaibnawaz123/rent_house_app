import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/activity/domain/entities/reserve_entity.dart';
import 'package:taxi_app/modules/activity/domain/params/reserve_param.dart';
import 'package:taxi_app/modules/activity/domain/usecase/reserve_use_case.dart';
import 'package:taxi_app/modules/activity/presentation/routes/reserve_view_initial_params.dart';

part 'reserve_event.dart';
part 'reserve_state.dart';

class ReserveBloc extends Bloc<ReserveEvent, ReserveState> {
  final ReserveViewInitialParams initialParams;
  final ReserveUseCase _useCase;

  ReserveBloc(this.initialParams, this._useCase)
      : super(ReserveState(initialParams: initialParams)) {
    on<LoadReserveEvent>(_loadReserveAction);
  }

  Future<void> _loadReserveAction(
      LoadReserveEvent event, Emitter<ReserveState> emit) async {
    emit(state.copyWith(reserveResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(reserveResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(reserveResponse: ApiResponse.completed(r)));
      },
    ));
  }
}