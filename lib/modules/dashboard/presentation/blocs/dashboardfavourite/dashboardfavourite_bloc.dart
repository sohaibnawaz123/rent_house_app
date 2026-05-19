import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardfavourite_entity.dart';
import 'package:taxi_app/modules/dashboard/domain/params/dashboardfavourite_param.dart';
import 'package:taxi_app/modules/dashboard/domain/usecase/dashboardfavourite_use_case.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardfavourite_view_initial_params.dart';

part 'dashboardfavourite_event.dart';
part 'dashboardfavourite_state.dart';

class DashboardfavouriteBloc extends Bloc<DashboardfavouriteEvent, DashboardfavouriteState> {
  final DashboardfavouriteViewInitialParams initialParams;
  final DashboardfavouriteUseCase _useCase;

  DashboardfavouriteBloc(this.initialParams, this._useCase)
      : super(DashboardfavouriteState(initialParams: initialParams)) {
    on<LoadDashboardfavouriteEvent>(_loadDashboardfavouriteAction);
  }

  Future<void> _loadDashboardfavouriteAction(
      LoadDashboardfavouriteEvent event, Emitter<DashboardfavouriteState> emit) async {
    emit(state.copyWith(dashboardfavouriteResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(dashboardfavouriteResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(dashboardfavouriteResponse: ApiResponse.completed(r)));
      },
    ));
  }
}