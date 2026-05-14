import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/register_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/register_param.dart';
import 'package:taxi_app/modules/auth/domain/usecase/register_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/routes/register_view_initial_params.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterViewInitialParams initialParams;
  final RegisterUseCase _useCase;

  RegisterBloc(this.initialParams, this._useCase)
      : super(RegisterState(initialParams: initialParams)) {
    on<LoadRegisterEvent>(_loadRegisterAction);
  }

  Future<void> _loadRegisterAction(
      LoadRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(registerResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(registerResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(registerResponse: ApiResponse.completed(r)));
      },
    ));
  }
}