import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/failures/store_failure.dart';

abstract class Store {
  Either<StoreFailure, T> write<T>(String key, T value);
  Either<StoreFailure, T> read<T>(String key);
  Either<StoreFailure, bool> delete<T>(String key);
}
