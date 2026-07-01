import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/login_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/logout_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/login_param.dart';
import 'package:taxi_app/modules/auth/domain/params/logout_param.dart';
import 'package:taxi_app/modules/auth/domain/usecase/login_use_case.dart';
import 'package:taxi_app/modules/auth/domain/usecase/logout_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/routes/login_view_initial_params.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginViewInitialParams initialParams;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  LoginBloc(this.initialParams, this._loginUseCase, this._logoutUseCase)
      : super(LoginState(initialParams: initialParams)) {
    on<LoadLoginEvent>(_loadLoginAction);
    on<LoadLogoutEvent>(_loadLogoutAction);
  }

  Future<void> _loadLoginAction(
      LoadLoginEvent event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        loginResponse: ApiResponse.loading(),
        logoutResponse: const ApiResponse.init(),
      ),
    );
    
    await _loginUseCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(loginResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(loginResponse: ApiResponse.completed(r)));
      },
    ));
  }

  Future<void> _loadLogoutAction(
    LoadLogoutEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        logoutResponse: ApiResponse.loading(),
        loginResponse: const ApiResponse.init(),
      ),
    );

    await _logoutUseCase.execute(
      LogoutParam(accessToken: event.accessToken),
    ).then(
      (value) => value.fold(
        (l) {
          emit(state.copyWith(logoutResponse: ApiResponse.error(l.error)));
        },
        (r) {
          emit(state.copyWith(logoutResponse: ApiResponse.completed(r)));
        },
      ),
    );
  }
}
