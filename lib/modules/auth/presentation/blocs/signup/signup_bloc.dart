import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/signup_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/signup_param.dart';
import 'package:taxi_app/modules/auth/domain/usecase/signup_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/routes/signup_view_initial_params.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupViewInitialParams initialParams;
  final SignupUseCase _useCase;

  SignupBloc(this.initialParams, this._useCase)
      : super(SignupState(initialParams: initialParams)) {
    on<LoadSignupEvent>(_loadSignupAction);
  }

  Future<void> _loadSignupAction(
      LoadSignupEvent event, Emitter<SignupState> emit) async {
    emit(state.copyWith(signupResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(signupResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(signupResponse: ApiResponse.completed(r)));
      },
    ));
  }
}