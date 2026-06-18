part of 'reserve_bloc.dart';

class ReserveState extends Equatable {
  final ReserveViewInitialParams initialParams;
  final ApiResponse<BaseEntity<ReserveEntity>> reserveResponse;

  const ReserveState({
    required this.initialParams,
    this.reserveResponse = const ApiResponse.init(),
  });

   ReserveState copyWith({
    ReserveViewInitialParams? initialParams,
    ApiResponse<BaseEntity<ReserveEntity>>? reserveResponse,
  }) {
    ReserveState data =   ReserveState(
      initialParams: initialParams ?? this.initialParams,
      reserveResponse: reserveResponse ?? this.reserveResponse,
    );
    Utils.logInfo(data.toString(), name: "Reserve");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, reserveResponse];

  @override
  String toString() {
    return 'ReserveState(initialParams: $initialParams, reserveResponse: ${reserveResponse.toString()})';
  }
}
