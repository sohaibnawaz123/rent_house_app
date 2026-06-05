import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/recent_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/recent_param.dart';
import 'package:taxi_app/modules/setting/domain/usecase/recent_use_case.dart';
import 'package:taxi_app/modules/setting/presentation/routes/recent_view_initial_params.dart';

part 'recent_event.dart';
part 'recent_state.dart';

class RecentBloc extends Bloc<RecentEvent, RecentState> {
  final RecentViewInitialParams initialParams;
  final RecentUseCase _useCase;

  RecentBloc(this.initialParams, this._useCase)
      : super(RecentState(initialParams: initialParams)) {
    on<LoadRecentEvent>(_loadRecentAction);
  }

  Future<void> _loadRecentAction(
      LoadRecentEvent event, Emitter<RecentState> emit) async {
    emit(state.copyWith(recentResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(recentResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(recentResponse: ApiResponse.completed(r)));
      },
    ));
  }
}