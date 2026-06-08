import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/activity/domain/entities/propertydetail_entity.dart';
import 'package:taxi_app/modules/activity/domain/params/propertydetail_param.dart';
import 'package:taxi_app/modules/activity/domain/usecase/propertydetail_use_case.dart';
import 'package:taxi_app/modules/activity/presentation/routes/propertydetail_view_initial_params.dart';

part 'propertydetail_event.dart';
part 'propertydetail_state.dart';

class PropertydetailBloc extends Bloc<PropertydetailEvent, PropertydetailState> {
  final PropertydetailViewInitialParams initialParams;
  final PropertydetailUseCase _useCase;

  PropertydetailBloc(this.initialParams, this._useCase)
      : super(PropertydetailState(initialParams: initialParams)) {
    on<LoadPropertydetailEvent>(_loadPropertydetailAction);
  }

  Future<void> _loadPropertydetailAction(
      LoadPropertydetailEvent event, Emitter<PropertydetailState> emit) async {
    emit(state.copyWith(propertydetailResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(propertydetailResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(propertydetailResponse: ApiResponse.completed(r)));
      },
    ));
  }
}