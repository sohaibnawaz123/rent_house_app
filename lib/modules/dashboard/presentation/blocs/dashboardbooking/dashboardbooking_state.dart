part of 'dashboardbooking_bloc.dart';

class DashboardbookingState extends Equatable {
  final DashboardbookingViewInitialParams initialParams;
  final ApiResponse<BaseEntity<DashboardbookingEntity>> dashboardbookingResponse;

  const DashboardbookingState({
    required this.initialParams,
    this.dashboardbookingResponse = const ApiResponse.init(),
  });

   DashboardbookingState copyWith({
    DashboardbookingViewInitialParams? initialParams,
    ApiResponse<BaseEntity<DashboardbookingEntity>>? dashboardbookingResponse,
  }) {
    DashboardbookingState data =   DashboardbookingState(
      initialParams: initialParams ?? this.initialParams,
      dashboardbookingResponse: dashboardbookingResponse ?? this.dashboardbookingResponse,
    );
    Utils.logInfo(data.toString(), name: "Dashboardbooking");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, dashboardbookingResponse];

  @override
  String toString() {
    return 'DashboardbookingState(initialParams: $initialParams, dashboardbookingResponse: ${dashboardbookingResponse.toString()})';
  }
}
