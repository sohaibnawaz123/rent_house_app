import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardhome_param.dart';
import 'package:taxi_app/modules/dashboard/domain/usecase/dashboardhome_use_case.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardhome_view_initial_params.dart';

part 'dashboardhome_event.dart';
part 'dashboardhome_state.dart';

class DashboardhomeBloc extends Bloc<DashboardhomeEvent, DashboardhomeState> {
  final DashboardhomeViewInitialParams initialParams;
  final DashboardhomeUseCase _useCase;

  DashboardhomeBloc(this.initialParams, this._useCase)
      : super(DashboardhomeState(initialParams: initialParams)) {
    on<LoadDashboardhomeEvent>(_loadDashboardhomeAction);
  }

  Future<void> _loadDashboardhomeAction(
      LoadDashboardhomeEvent event, Emitter<DashboardhomeState> emit) async {
    emit(state.copyWith(dashboardhomeResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(dashboardhomeResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(dashboardhomeResponse: ApiResponse.completed(r)));
      },
    ));
  }
}