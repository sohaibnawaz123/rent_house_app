part of 'dashboardhome_bloc.dart';

class DashboardhomeState extends Equatable {
  final DashboardhomeViewInitialParams initialParams;
  final ApiResponse<BaseEntity<DashboardhomeEntity>> dashboardhomeResponse;

  const DashboardhomeState({
    required this.initialParams,
    this.dashboardhomeResponse = const ApiResponse.init(),
  });

   DashboardhomeState copyWith({
    DashboardhomeViewInitialParams? initialParams,
    ApiResponse<BaseEntity<DashboardhomeEntity>>? dashboardhomeResponse,
  }) {
    DashboardhomeState data =   DashboardhomeState(
      initialParams: initialParams ?? this.initialParams,
      dashboardhomeResponse: dashboardhomeResponse ?? this.dashboardhomeResponse,
    );
    Utils.logInfo(data.toString(), name: "Dashboardhome");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, dashboardhomeResponse];

  @override
  String toString() {
    return 'DashboardhomeState(initialParams: $initialParams, dashboardhomeResponse: ${dashboardhomeResponse.toString()})';
  }
}
