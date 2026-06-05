part of 'recent_bloc.dart';

class RecentState extends Equatable {
  final RecentViewInitialParams initialParams;
  final ApiResponse<BaseEntity<RecentEntity>> recentResponse;

  const RecentState({
    required this.initialParams,
    this.recentResponse = const ApiResponse.init(),
  });

   RecentState copyWith({
    RecentViewInitialParams? initialParams,
    ApiResponse<BaseEntity<RecentEntity>>? recentResponse,
  }) {
    RecentState data =   RecentState(
      initialParams: initialParams ?? this.initialParams,
      recentResponse: recentResponse ?? this.recentResponse,
    );
    Utils.logInfo(data.toString(), name: "Recent");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, recentResponse];

  @override
  String toString() {
    return 'RecentState(initialParams: $initialParams, recentResponse: ${recentResponse.toString()})';
  }
}
