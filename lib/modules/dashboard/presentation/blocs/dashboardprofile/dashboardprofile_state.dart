part of 'dashboardprofile_bloc.dart';

class DashboardprofileState extends Equatable {
  final DashboardprofileViewInitialParams initialParams;
  final ApiResponse<BaseEntity<DashboardprofileEntity>> dashboardprofileResponse;

  const DashboardprofileState({
    required this.initialParams,
    this.dashboardprofileResponse = const ApiResponse.init(),
  });

   DashboardprofileState copyWith({
    DashboardprofileViewInitialParams? initialParams,
    ApiResponse<BaseEntity<DashboardprofileEntity>>? dashboardprofileResponse,
  }) {
    DashboardprofileState data =   DashboardprofileState(
      initialParams: initialParams ?? this.initialParams,
      dashboardprofileResponse: dashboardprofileResponse ?? this.dashboardprofileResponse,
    );
    Utils.logInfo(data.toString(), name: "Dashboardprofile");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, dashboardprofileResponse];

  @override
  String toString() {
    return 'DashboardprofileState(initialParams: $initialParams, dashboardprofileResponse: ${dashboardprofileResponse.toString()})';
  }
}
