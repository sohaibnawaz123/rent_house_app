import 'package:taxi_app/modules/app/domain/entitties/base_entity.dart';


class BaseJson<T> {
  final String? message;
  final T? data;
  final String? curser;

  BaseJson({this.message, this.data, this.curser});

  factory BaseJson.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromDataJson,
  ) {
    return BaseJson<T>(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : fromDataJson(json['data'] as Map<String, dynamic>),

      // Supports multiple API naming conventions
      curser:
          json['curser'] as String? ??
          json['cursor'] as String? ??
          json['nextCursor'] as String?,
    );
  }

  Map<String, dynamic> toJson(
    Map<String, dynamic> Function(T? data) toDataJson,
  ) => {
    'message': message,
    'data': toDataJson(data),

    // Send as nextCursor to API
    if (curser != null) 'nextCursor': curser,
  };

  BaseEntity<R> toDomain<R>(R Function(T? data) toDataDomain) {
    return BaseEntity<R>(
      message: message ?? '',
      data: toDataDomain(data),
      nextCursor: curser ?? '',
    );
  }
}

// class BaseJson<T> {
//   final T? data;
//   final PaginationJson? pagination;
//   final DateTime? generatedAt;
//   final String? statusCode;
//   final String? userMessage;
//   final dynamic systemMessage;
//   final dynamic systemErrorMessage;
//   final dynamic systemErrorType;
//   final dynamic systemErrorStack;
//   final dynamic validationProblemDetails;

//   BaseJson({
//     this.data,
//     this.pagination,
//     this.generatedAt,
//     this.statusCode,
//     this.userMessage,
//     this.systemMessage,
//     this.systemErrorMessage,
//     this.systemErrorType,
//     this.systemErrorStack,
//     this.validationProblemDetails,
//   });

//   factory BaseJson.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromDataJson) {
//     return BaseJson(
//       data: json['data'] == null
//           ? null
//           : (json['data'] is List)
//               ? (json['data'] as List<dynamic>).map((e) => fromDataJson(e as Map<String, dynamic>)).toList() as T
//               : fromDataJson(json['data']),
//       pagination: json['pagination'] == null ? null : PaginationJson.fromJson(json['pagination'] as Map<String, dynamic>),
//       generatedAt: json['generatedAt'] == null ? null : DateTime.parse(json['generatedAt'] as String),
//       statusCode: json['statusCode'] as String?,
//       userMessage: json['userMessage'] as String?,
//       systemMessage: json['systemMessage'] as dynamic,
//       systemErrorMessage: json['systemErrorMessage'] as dynamic,
//       systemErrorType: json['systemErrorType'] as dynamic,
//       systemErrorStack: json['systemErrorStack'] as dynamic,
//       validationProblemDetails: json['validationProblemDetails'] as dynamic,
//     );
//   }

//   Map<String, dynamic> toJson(Map<String, dynamic> Function(T?) toDataJson) => {
//         'data': toDataJson(data),
//         'generatedAt': generatedAt?.toIso8601String(),
//         'statusCode': statusCode,
//         'userMessage': userMessage,
//         'systemMessage': systemMessage,
//         'systemErrorMessage': systemErrorMessage,
//         'systemErrorType': systemErrorType,
//         'systemErrorStack': systemErrorStack,
//         'validationProblemDetails': validationProblemDetails,
//       };

//   BaseEntity<R> toDomain<R>(R Function(T?) toDataDomain) {
//     return BaseEntity(
//         data: toDataDomain(data),
//         generatedAt: generatedAt ?? DateTime.now(),
//         statusCode: statusCode ?? '400',
//         userMessage: userMessage ?? 'None',
//         pagination: pagination?.toDomain() ?? PaginationEntity.empty());
//   }
// }
