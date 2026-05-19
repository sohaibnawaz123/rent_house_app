part of 'dashboardroot_bloc.dart';

class DashboardrootState extends Equatable {
  final DashboardrootViewInitialParams initialParams;
  final ApiResponse<BaseEntity<DashboardrootEntity>> dashboardrootResponse;

  const DashboardrootState({
    required this.initialParams,
    this.dashboardrootResponse = const ApiResponse.init(),
  });

   DashboardrootState copyWith({
    DashboardrootViewInitialParams? initialParams,
    ApiResponse<BaseEntity<DashboardrootEntity>>? dashboardrootResponse,
  }) {
    DashboardrootState data =   DashboardrootState(
      initialParams: initialParams ?? this.initialParams,
      dashboardrootResponse: dashboardrootResponse ?? this.dashboardrootResponse,
    );
    Utils.logInfo(data.toString(), name: "Dashboardroot");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, dashboardrootResponse];

  @override
  String toString() {
    return 'DashboardrootState(initialParams: $initialParams, dashboardrootResponse: ${dashboardrootResponse.toString()})';
  }
}
