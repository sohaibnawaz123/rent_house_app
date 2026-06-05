part of 'about_bloc.dart';

class AboutState extends Equatable {
  final AboutViewInitialParams initialParams;
  final ApiResponse<BaseEntity<AboutEntity>> aboutResponse;

  const AboutState({
    required this.initialParams,
    this.aboutResponse = const ApiResponse.init(),
  });

   AboutState copyWith({
    AboutViewInitialParams? initialParams,
    ApiResponse<BaseEntity<AboutEntity>>? aboutResponse,
  }) {
    AboutState data =   AboutState(
      initialParams: initialParams ?? this.initialParams,
      aboutResponse: aboutResponse ?? this.aboutResponse,
    );
    Utils.logInfo(data.toString(), name: "About");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, aboutResponse];

  @override
  String toString() {
    return 'AboutState(initialParams: $initialParams, aboutResponse: ${aboutResponse.toString()})';
  }
}
