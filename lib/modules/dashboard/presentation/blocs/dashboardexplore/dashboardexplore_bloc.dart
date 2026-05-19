import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardexplore_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardexplore_param.dart';
import 'package:taxi_app/modules/dashboard/domain/usecase/dashboardexplore_use_case.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardexplore_view_initial_params.dart';

part 'dashboardexplore_event.dart';
part 'dashboardexplore_state.dart';

class DashboardexploreBloc extends Bloc<DashboardexploreEvent, DashboardexploreState> {
  final DashboardexploreViewInitialParams initialParams;
  final DashboardexploreUseCase _useCase;

  DashboardexploreBloc(this.initialParams, this._useCase)
      : super(DashboardexploreState(initialParams: initialParams)) {
    on<LoadDashboardexploreEvent>(_loadDashboardexploreAction);
  }

  Future<void> _loadDashboardexploreAction(
      LoadDashboardexploreEvent event, Emitter<DashboardexploreState> emit) async {
    emit(state.copyWith(dashboardexploreResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(dashboardexploreResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(dashboardexploreResponse: ApiResponse.completed(r)));
      },
    ));
  }
}