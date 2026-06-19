import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/activity/domain/entities/bookingreviews_entity.dart';
import 'package:taxi_app/modules/activity/domain/params/bookingreviews_param.dart';
import 'package:taxi_app/modules/activity/domain/usecase/bookingreviews_use_case.dart';
import 'package:taxi_app/modules/activity/presentation/routes/bookingreviews_view_initial_params.dart';

part 'bookingreviews_event.dart';
part 'bookingreviews_state.dart';

class BookingreviewsBloc extends Bloc<BookingreviewsEvent, BookingreviewsState> {
  final BookingreviewsViewInitialParams initialParams;
  final BookingreviewsUseCase _useCase;

  BookingreviewsBloc(this.initialParams, this._useCase)
      : super(BookingreviewsState(initialParams: initialParams)) {
    on<LoadBookingreviewsEvent>(_loadBookingreviewsAction);
  }

  Future<void> _loadBookingreviewsAction(
      LoadBookingreviewsEvent event, Emitter<BookingreviewsState> emit) async {
    emit(state.copyWith(bookingreviewsResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(bookingreviewsResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(bookingreviewsResponse: ApiResponse.completed(r)));
      },
    ));
  }
}