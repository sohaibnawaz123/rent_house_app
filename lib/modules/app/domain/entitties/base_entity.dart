import 'package:taxi_app/modules/app/domain/entitties/pagination_entity.dart';

class BaseEntity<T> {
  final String message;
  final T data;
  final PaginationEntity? pagination;

  BaseEntity({required this.message, required this.data, this.pagination});
}

// class BaseEntity<T> {
//   final T data;
//   final PaginationEntity pagination;
//   final DateTime generatedAt;
//   final String statusCode;
//   final String userMessage;

//   BaseEntity({
//     required this.data,
//     required this.pagination,
//     required this.generatedAt,
//     required this.statusCode,
//     required this.userMessage,
//   });
// }
