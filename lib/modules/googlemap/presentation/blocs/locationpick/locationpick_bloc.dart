import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/entities/locationpick_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/params/locationpick_param.dart';
import 'package:taxi_app/modules/googlemap/domain/usecase/locationpick_use_case.dart';
import 'package:taxi_app/modules/googlemap/presentation/routes/locationpick_view_initial_params.dart';

part 'locationpick_event.dart';
part 'locationpick_state.dart';

class LocationpickBloc extends Bloc<LocationpickEvent, LocationpickState> {
  final LocationpickViewInitialParams initialParams;
  final LocationpickUseCase _useCase;

  LocationpickBloc(this.initialParams, this._useCase)
      : super(LocationpickState(initialParams: initialParams)) {
    on<LoadLocationpickEvent>(_loadLocationpickAction);
  }

  Future<void> _loadLocationpickAction(
      LoadLocationpickEvent event, Emitter<LocationpickState> emit) async {
    emit(state.copyWith(locationpickResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(locationpickResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(locationpickResponse: ApiResponse.completed(r)));
      },
    ));
  }
}