import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardbooking_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardbooking_param.dart';
import 'package:taxi_app/modules/dashboard/domain/usecase/dashboardbooking_use_case.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardbooking_view_initial_params.dart';

part 'dashboardbooking_event.dart';
part 'dashboardbooking_state.dart';

class DashboardbookingBloc extends Bloc<DashboardbookingEvent, DashboardbookingState> {
  final DashboardbookingViewInitialParams initialParams;
  final DashboardbookingUseCase _useCase;

  DashboardbookingBloc(this.initialParams, this._useCase)
      : super(DashboardbookingState(initialParams: initialParams)) {
    on<LoadDashboardbookingEvent>(_loadDashboardbookingAction);
  }

  Future<void> _loadDashboardbookingAction(
      LoadDashboardbookingEvent event, Emitter<DashboardbookingState> emit) async {
    emit(state.copyWith(dashboardbookingResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(dashboardbookingResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(dashboardbookingResponse: ApiResponse.completed(r)));
      },
    ));
  }
}