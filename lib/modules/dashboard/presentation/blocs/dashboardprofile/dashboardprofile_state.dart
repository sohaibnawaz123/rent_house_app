part of 'dashboardprofile_bloc.dart';

class DashboardprofileState extends Equatable {
  final DashboardprofileViewInitialParams initialParams;
  final ApiResponse<BaseEntity<DashboardprofileEntity>>
  dashboardprofileResponse;
  final File? image;

  const DashboardprofileState({
    required this.initialParams,
    this.dashboardprofileResponse = const ApiResponse.init(),
    this.image,
  });

  DashboardprofileState copyWith({
    DashboardprofileViewInitialParams? initialParams,
    ApiResponse<BaseEntity<DashboardprofileEntity>>? dashboardprofileResponse,
    File? image,
  }) {
    DashboardprofileState data = DashboardprofileState(
      initialParams: initialParams ?? this.initialParams,
      dashboardprofileResponse:
          dashboardprofileResponse ?? this.dashboardprofileResponse,
      image: image ?? this.image,
    );
    Utils.logInfo(data.toString(), name: "Dashboardprofile");
    return data;
  }

  @override
  List<Object?> get props => [initialParams, dashboardprofileResponse, image];

  @override
  String toString() {
    return 'DashboardprofileState(initialParams: $initialParams, dashboardprofileResponse: ${dashboardprofileResponse.toString()}, imageurl:$image)';
  }
}
