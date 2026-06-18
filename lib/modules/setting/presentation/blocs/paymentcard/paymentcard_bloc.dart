import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/paymentcard_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/paymentcard_param.dart';
import 'package:taxi_app/modules/setting/domain/usecase/paymentcard_use_case.dart';
import 'package:taxi_app/modules/setting/presentation/routes/paymentcard_view_initial_params.dart';

part 'paymentcard_event.dart';
part 'paymentcard_state.dart';

class PaymentcardBloc extends Bloc<PaymentcardEvent, PaymentcardState> {
  final PaymentcardViewInitialParams initialParams;
  final PaymentcardUseCase _useCase;

  PaymentcardBloc(this.initialParams, this._useCase)
      : super(PaymentcardState(initialParams: initialParams)) {
    on<LoadPaymentcardEvent>(_loadPaymentcardAction);
  }

  Future<void> _loadPaymentcardAction(
      LoadPaymentcardEvent event, Emitter<PaymentcardState> emit) async {
    emit(state.copyWith(paymentcardResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(paymentcardResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(paymentcardResponse: ApiResponse.completed(r)));
      },
    ));
  }
}