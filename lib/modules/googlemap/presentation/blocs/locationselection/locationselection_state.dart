part of 'locationselection_bloc.dart';

class LocationselectionState extends Equatable {
  final LocationselectionViewInitialParams initialParams;
  final ApiResponse<BaseEntity<LocationselectionEntity>> locationselectionResponse;

  const LocationselectionState({
    required this.initialParams,
    this.locationselectionResponse = const ApiResponse.init(),
  });

   LocationselectionState copyWith({
    LocationselectionViewInitialParams? initialParams,
    ApiResponse<BaseEntity<LocationselectionEntity>>? locationselectionResponse,
  }) {
    LocationselectionState data =   LocationselectionState(
      initialParams: initialParams ?? this.initialParams,
      locationselectionResponse: locationselectionResponse ?? this.locationselectionResponse,
    );
    Utils.logInfo(data.toString(), name: "Locationselection");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, locationselectionResponse];

  @override
  String toString() {
    return 'LocationselectionState(initialParams: $initialParams, locationselectionResponse: ${locationselectionResponse.toString()})';
  }
}
