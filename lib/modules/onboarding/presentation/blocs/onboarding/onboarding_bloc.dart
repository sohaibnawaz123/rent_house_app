import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/features/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/onboarding/domain/entities/onboarding_entity.dart';
import 'package:taxi_app/modules/onboarding/domain/params/onboarding_param.dart';
import 'package:taxi_app/modules/onboarding/domain/usecase/onboarding_use_case.dart';
import 'package:taxi_app/modules/onboarding/presentation/routes/onboarding_view_initial_params.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingViewInitialParams initialParams;
  final OnboardingUseCase _useCase;

  OnboardingBloc(this.initialParams, this._useCase)
      : super(OnboardingState(initialParams: initialParams)) {
    on<LoadOnboardingEvent>(_loadOnboardingAction);
  }

  Future<void> _loadOnboardingAction(
      LoadOnboardingEvent event, Emitter<OnboardingState> emit) async {
    emit(state.copyWith(onboardingResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(onboardingResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(onboardingResponse: ApiResponse.completed(r)));
      },
    ));
  }
}