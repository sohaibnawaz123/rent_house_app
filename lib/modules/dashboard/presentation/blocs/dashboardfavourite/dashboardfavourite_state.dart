part of 'dashboardfavourite_bloc.dart';

class DashboardfavouriteState extends Equatable {
  final DashboardfavouriteViewInitialParams initialParams;
  final ApiResponse<BaseEntity<DashboardfavouriteEntity>> dashboardfavouriteResponse;

  const DashboardfavouriteState({
    required this.initialParams,
    this.dashboardfavouriteResponse = const ApiResponse.init(),
  });

   DashboardfavouriteState copyWith({
    DashboardfavouriteViewInitialParams? initialParams,
    ApiResponse<BaseEntity<DashboardfavouriteEntity>>? dashboardfavouriteResponse,
  }) {
    DashboardfavouriteState data =   DashboardfavouriteState(
      initialParams: initialParams ?? this.initialParams,
      dashboardfavouriteResponse: dashboardfavouriteResponse ?? this.dashboardfavouriteResponse,
    );
    Utils.logInfo(data.toString(), name: "Dashboardfavourite");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, dashboardfavouriteResponse];

  @override
  String toString() {
    return 'DashboardfavouriteState(initialParams: $initialParams, dashboardfavouriteResponse: ${dashboardfavouriteResponse.toString()})';
  }
}
