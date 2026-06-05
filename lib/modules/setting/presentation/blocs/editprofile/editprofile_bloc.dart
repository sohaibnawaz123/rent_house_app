import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/editprofile_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/editprofile_param.dart';
import 'package:taxi_app/modules/setting/domain/usecase/editprofile_use_case.dart';
import 'package:taxi_app/modules/setting/presentation/routes/editprofile_view_initial_params.dart';

part 'editprofile_event.dart';
part 'editprofile_state.dart';

class EditprofileBloc extends Bloc<EditprofileEvent, EditprofileState> {
  final EditprofileViewInitialParams initialParams;
  final EditprofileUseCase _useCase;

  EditprofileBloc(this.initialParams, this._useCase)
      : super(EditprofileState(initialParams: initialParams)) {
    on<LoadEditprofileEvent>(_loadEditprofileAction);
  }

  Future<void> _loadEditprofileAction(
      LoadEditprofileEvent event, Emitter<EditprofileState> emit) async {
    emit(state.copyWith(editprofileResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(editprofileResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(editprofileResponse: ApiResponse.completed(r)));
      },
    ));
  }
}