import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/api_response.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';
import 'package:taxi_app/modules/setting/domain/entities/payment_entity.dart';
import 'package:taxi_app/modules/setting/domain/params/payment_param.dart';
import 'package:taxi_app/modules/setting/domain/usecase/payment_use_case.dart';
import 'package:taxi_app/modules/setting/presentation/routes/payment_view_initial_params.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentViewInitialParams initialParams;
  final PaymentUseCase _useCase;

  PaymentBloc(this.initialParams, this._useCase)
      : super(PaymentState(initialParams: initialParams)) {
    on<LoadPaymentEvent>(_loadPaymentAction);
  }

  Future<void> _loadPaymentAction(
      LoadPaymentEvent event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(paymentResponse: ApiResponse.loading()));
    
    await _useCase.execute(event.param).then((value) => value.fold(
      (l) {
        emit(state.copyWith(paymentResponse: ApiResponse.error(l.error)));
      }, 
      (r) {
        emit(state.copyWith(paymentResponse: ApiResponse.completed(r)));
      },
    ));
  }
}