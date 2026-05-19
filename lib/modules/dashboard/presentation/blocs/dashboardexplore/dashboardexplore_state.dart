part of 'dashboardexplore_bloc.dart';

class DashboardexploreState extends Equatable {
  final DashboardexploreViewInitialParams initialParams;
  final ApiResponse<BaseEntity<DashboardexploreEntity>> dashboardexploreResponse;

  const DashboardexploreState({
    required this.initialParams,
    this.dashboardexploreResponse = const ApiResponse.init(),
  });

   DashboardexploreState copyWith({
    DashboardexploreViewInitialParams? initialParams,
    ApiResponse<BaseEntity<DashboardexploreEntity>>? dashboardexploreResponse,
  }) {
    DashboardexploreState data =   DashboardexploreState(
      initialParams: initialParams ?? this.initialParams,
      dashboardexploreResponse: dashboardexploreResponse ?? this.dashboardexploreResponse,
    );
    Utils.logInfo(data.toString(), name: "Dashboardexplore");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, dashboardexploreResponse];

  @override
  String toString() {
    return 'DashboardexploreState(initialParams: $initialParams, dashboardexploreResponse: ${dashboardexploreResponse.toString()})';
  }
}
