import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/about_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/about_param.dart';
import 'package:taxi_app/modules/setting/domain/usecase/about_use_case.dart';
import 'package:taxi_app/modules/setting/presentation/routes/about_view_initial_params.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  final AboutViewInitialParams initialParams;
  final AboutUseCase _useCase;

  AboutBloc(this.initialParams, this._useCase)
      : super(AboutState(initialParams: initialParams)) {
    on<LoadAboutEvent>(_loadAboutAction);
  }

  Future<void> _loadAboutAction(
      LoadAboutEvent event, Emitter<AboutState> emit) async {
    emit(state.copyWith(aboutResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(aboutResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(aboutResponse: ApiResponse.completed(r)));
      },
    ));
  }
}