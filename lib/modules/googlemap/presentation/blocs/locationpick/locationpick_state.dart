part of 'locationpick_bloc.dart';

class LocationpickState extends Equatable {
  final LocationpickViewInitialParams initialParams;
  final ApiResponse<BaseEntity<LocationpickEntity>> locationpickResponse;

  const LocationpickState({
    required this.initialParams,
    this.locationpickResponse = const ApiResponse.init(),
  });

   LocationpickState copyWith({
    LocationpickViewInitialParams? initialParams,
    ApiResponse<BaseEntity<LocationpickEntity>>? locationpickResponse,
  }) {
    LocationpickState data =   LocationpickState(
      initialParams: initialParams ?? this.initialParams,
      locationpickResponse: locationpickResponse ?? this.locationpickResponse,
    );
    Utils.logInfo(data.toString(), name: "Locationpick");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, locationpickResponse];

  @override
  String toString() {
    return 'LocationpickState(initialParams: $initialParams, locationpickResponse: ${locationpickResponse.toString()})';
  }
}
