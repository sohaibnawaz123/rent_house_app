part of 'refreshtoken_bloc.dart';

class RefreshtokenState extends Equatable {
  final RefreshtokenViewInitialParams initialParams;
  final ApiResponse<BaseEntity<RefreshtokenEntity>> refreshtokenResponse;

  const RefreshtokenState({
    required this.initialParams,
    this.refreshtokenResponse = const ApiResponse.init(),
  });

   RefreshtokenState copyWith({
    RefreshtokenViewInitialParams? initialParams,
    ApiResponse<BaseEntity<RefreshtokenEntity>>? refreshtokenResponse,
  }) {
    RefreshtokenState data =   RefreshtokenState(
      initialParams: initialParams ?? this.initialParams,
      refreshtokenResponse: refreshtokenResponse ?? this.refreshtokenResponse,
    );
    Utils.logInfo(data.toString(), name: "Refreshtoken");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, refreshtokenResponse];

  @override
  String toString() {
    return 'RefreshtokenState(initialParams: $initialParams, refreshtokenResponse: ${refreshtokenResponse.toString()})';
  }
}
