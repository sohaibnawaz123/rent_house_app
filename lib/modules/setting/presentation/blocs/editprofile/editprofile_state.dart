part of 'editprofile_bloc.dart';

class EditprofileState extends Equatable {
  final EditprofileViewInitialParams initialParams;
  final ApiResponse<BaseEntity<EditprofileEntity>> editprofileResponse;

  const EditprofileState({
    required this.initialParams,
    this.editprofileResponse = const ApiResponse.init(),
  });

   EditprofileState copyWith({
    EditprofileViewInitialParams? initialParams,
    ApiResponse<BaseEntity<EditprofileEntity>>? editprofileResponse,
  }) {
    EditprofileState data =   EditprofileState(
      initialParams: initialParams ?? this.initialParams,
      editprofileResponse: editprofileResponse ?? this.editprofileResponse,
    );
    Utils.logInfo(data.toString(), name: "Editprofile");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, editprofileResponse];

  @override
  String toString() {
    return 'EditprofileState(initialParams: $initialParams, editprofileResponse: ${editprofileResponse.toString()})';
  }
}
