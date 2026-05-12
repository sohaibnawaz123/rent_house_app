import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/login_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/login_param.dart';
import 'package:taxi_app/modules/auth/domain/usecase/login_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/routes/login_view_initial_params.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginViewInitialParams initialParams;
  final LoginUseCase _useCase;

  LoginBloc(this.initialParams, this._useCase)
      : super(LoginState(initialParams: initialParams)) {
    on<LoadLoginEvent>(_loadLoginAction);
  }

  Future<void> _loadLoginAction(
      LoadLoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(loginResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(loginResponse: ApiResponse.completed(r)));
      },
    ));
  }
}