part of 'dashboardhome_bloc.dart';

class DashboardhomeState extends Equatable {
  final DashboardhomeViewInitialParams initialParams;
  final ApiResponse<BaseEntity<DashboardhomeEntity>> dashboardhomeResponse;
  final ApiResponse<BaseEntity<LocationpickEntity>> dashboardhomeadressResponse;

  const DashboardhomeState({
    required this.initialParams,
    this.dashboardhomeResponse = const ApiResponse.init(),
    this.dashboardhomeadressResponse = const ApiResponse.init(),
  });

  DashboardhomeState copyWith({
    DashboardhomeViewInitialParams? initialParams,
    ApiResponse<BaseEntity<DashboardhomeEntity>>? dashboardhomeResponse,
    ApiResponse<BaseEntity<LocationpickEntity>>? dashboardhomeadressResponse,
  }) {
    DashboardhomeState data = DashboardhomeState(
      initialParams: initialParams ?? this.initialParams,
      dashboardhomeResponse:
          dashboardhomeResponse ?? this.dashboardhomeResponse,
      dashboardhomeadressResponse:
          dashboardhomeadressResponse ?? this.dashboardhomeadressResponse,
    );
    Utils.logInfo(data.toString(), name: "Dashboardhome");
    return data;
  }

  @override
  List<Object?> get props => [
    initialParams,
    dashboardhomeResponse,
    dashboardhomeadressResponse,
  ];

  @override
  String toString() {
    return 'DashboardhomeState(initialParams: $initialParams, dashboardhomeResponse: ${dashboardhomeResponse.toString()} ,  dashboardhomeResponse: ${dashboardhomeadressResponse.toString()})';
  }
}
