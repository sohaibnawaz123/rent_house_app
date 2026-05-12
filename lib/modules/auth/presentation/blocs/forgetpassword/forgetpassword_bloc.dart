import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/forgetpassword_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/forgetpassword_param.dart';
import 'package:taxi_app/modules/auth/domain/usecase/forgetpassword_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/routes/forgetpassword_view_initial_params.dart';

part 'forgetpassword_event.dart';
part 'forgetpassword_state.dart';

class ForgetpasswordBloc extends Bloc<ForgetpasswordEvent, ForgetpasswordState> {
  final ForgetpasswordViewInitialParams initialParams;
  final ForgetpasswordUseCase _useCase;

  ForgetpasswordBloc(this.initialParams, this._useCase)
      : super(ForgetpasswordState(initialParams: initialParams)) {
    on<LoadForgetpasswordEvent>(_loadForgetpasswordAction);
  }

  Future<void> _loadForgetpasswordAction(
      LoadForgetpasswordEvent event, Emitter<ForgetpasswordState> emit) async {
    emit(state.copyWith(forgetpasswordResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(forgetpasswordResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(forgetpasswordResponse: ApiResponse.completed(r)));
      },
    ));
  }
}