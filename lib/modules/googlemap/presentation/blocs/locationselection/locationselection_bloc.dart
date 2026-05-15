import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/entities/locationselection_entity.dart';
import 'package:taxi_app/modules/googlemap/domain/params/locationselection_param.dart';
import 'package:taxi_app/modules/googlemap/domain/usecase/locationselection_use_case.dart';
import 'package:taxi_app/modules/googlemap/presentation/routes/locationselection_view_initial_params.dart';

part 'locationselection_event.dart';
part 'locationselection_state.dart';

class LocationselectionBloc extends Bloc<LocationselectionEvent, LocationselectionState> {
  final LocationselectionViewInitialParams initialParams;
  final LocationselectionUseCase _useCase;

  LocationselectionBloc(this.initialParams, this._useCase)
      : super(LocationselectionState(initialParams: initialParams)) {
    on<LoadLocationselectionEvent>(_loadLocationselectionAction);
  }

  Future<void> _loadLocationselectionAction(
      LoadLocationselectionEvent event, Emitter<LocationselectionState> emit) async {
    emit(state.copyWith(locationselectionResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(locationselectionResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(locationselectionResponse: ApiResponse.completed(r)));
      },
    ));
  }
}