import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardroot_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardroot_param.dart';
import 'package:taxi_app/modules/dashboard/domain/usecase/dashboardroot_use_case.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardroot_view_initial_params.dart';

part 'dashboardroot_event.dart';
part 'dashboardroot_state.dart';

class DashboardrootBloc extends Bloc<DashboardrootEvent, DashboardrootState> {
  final DashboardrootViewInitialParams initialParams;
  final DashboardrootUseCase _useCase;

  DashboardrootBloc(this.initialParams, this._useCase)
      : super(DashboardrootState(initialParams: initialParams)) {
    on<LoadDashboardrootEvent>(_loadDashboardrootAction);
  }

  Future<void> _loadDashboardrootAction(
      LoadDashboardrootEvent event, Emitter<DashboardrootState> emit) async {
    emit(state.copyWith(dashboardrootResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(dashboardrootResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(dashboardrootResponse: ApiResponse.completed(r)));
      },
    ));
  }
}