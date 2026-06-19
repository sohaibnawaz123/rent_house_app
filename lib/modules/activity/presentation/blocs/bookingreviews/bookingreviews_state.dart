part of 'bookingreviews_bloc.dart';

class BookingreviewsState extends Equatable {
  final BookingreviewsViewInitialParams initialParams;
  final ApiResponse<BaseEntity<BookingreviewsEntity>> bookingreviewsResponse;

  const BookingreviewsState({
    required this.initialParams,
    this.bookingreviewsResponse = const ApiResponse.init(),
  });

   BookingreviewsState copyWith({
    BookingreviewsViewInitialParams? initialParams,
    ApiResponse<BaseEntity<BookingreviewsEntity>>? bookingreviewsResponse,
  }) {
    BookingreviewsState data =   BookingreviewsState(
      initialParams: initialParams ?? this.initialParams,
      bookingreviewsResponse: bookingreviewsResponse ?? this.bookingreviewsResponse,
    );
    Utils.logInfo(data.toString(), name: "Bookingreviews");
    return data;
  }

 @override
  List<Object?> get props => [initialParams, bookingreviewsResponse];

  @override
  String toString() {
    return 'BookingreviewsState(initialParams: $initialParams, bookingreviewsResponse: ${bookingreviewsResponse.toString()})';
  }
}
