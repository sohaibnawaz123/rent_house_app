part of 'propertydetail_bloc.dart';

class PropertydetailState extends Equatable {
  final PropertydetailViewInitialParams initialParams;
  final ApiResponse<BaseEntity<PropertydetailEntity>> propertydetailResponse;

  const PropertydetailState({
    required this.initialParams,
    this.propertydetailResponse = const ApiResponse.init(),
  });

   PropertydetailState copyWith({
    PropertydetailViewInitialParams? initialParams,
    ApiResponse<BaseEntity<PropertydetailEntity>>? propertydetailResponse,
  }) {
    PropertydetailState data =   PropertydetailState(
      initialParams: initialParams ?? this.initialParams,
      propertydetailResponse: propertydetailResponse ?? this.propertydetailResponse,
    );
    Utils.logInfo(data.toString(), name: "Propertydetail");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, propertydetailResponse];

  @override
  String toString() {
    return 'PropertydetailState(initialParams: $initialParams, propertydetailResponse: ${propertydetailResponse.toString()})';
  }
}
