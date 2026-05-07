part of 'root_bloc.dart';

class RootState {
  final RootInitialParams initialParams;
  final int currentIndex;

  const RootState({
    required this.initialParams,
    required this.currentIndex,
  });

  RootState copyWith({
    RootInitialParams? initialParams,
    int? currentIndex,
  }) {
    RootState data = RootState(
      initialParams: initialParams ?? this.initialParams,
      currentIndex: currentIndex ?? this.currentIndex,
    );
    return data;
  }

  @override
  String toString() {
    return 'RootState(initialParams: $initialParams, RootResponse: ${currentIndex.toString()})';
  }
}
