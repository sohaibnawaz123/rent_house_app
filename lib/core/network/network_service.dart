import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_app/core/failures/network_failure.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'network.dart';

class NetworkService extends Network {
  final http.Client _client;

  NetworkService({http.Client? client}) : _client = client ?? http.Client();

  // -------------------------------------------------------------------------
  // Helper: build final Uri
  // -------------------------------------------------------------------------
  Uri _buildUri(
    String base, {
    String? pathVariable,
    Map<String, dynamic>? query,
  }) {
    var url = base;
    if (pathVariable != null && pathVariable.isNotEmpty) {
      url = '$url/$pathVariable';
    }
    final uri = Uri.parse(url);
    return query != null && query.isNotEmpty
        ? uri.replace(queryParameters: query)
        : uri;
  }

  // -------------------------------------------------------------------------
  // Helper: JSON request (GET / POST / PATCH / PUT / DELETE)
  // -------------------------------------------------------------------------
  Future<Either<NetworkFailure, dynamic>> _request({
    required String method,
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? header,
    Map<String, dynamic>? query,
    String? pathVariable,
  }) async {
    final uri = _buildUri(url, pathVariable: pathVariable, query: query);
    final headers = header ?? {};

    Utils.logInfo(uri.toString(), name: "$method URI");
    Utils.logInfo(headers.toString(), name: "$method Headers");
    if (body != null) Utils.logInfo(body.toString(), name: "$method Body");

    try {
      final response = switch (method) {
        'GET' => await _client.get(uri, headers: headers),
        'POST' => await _client.post(
          uri,
          headers: headers,
          body: jsonEncode(body),
        ),
        'PATCH' => await _client.patch(
          uri,
          headers: headers,
          body: jsonEncode(body),
        ),
        'PUT' => await _client.put(
          uri,
          headers: headers,
          body: jsonEncode(body),
        ),
        'DELETE' => await _client.delete(uri, headers: headers),
        _ => throw UnimplementedError('HTTP method $method not supported'),
      };

      final failure = _handleError(response);
      if (failure != null) return left(failure);

      final decoded = _decodeBody(response);
      Utils.logInfo(decoded.toString(), name: "$method Response");
      return right(decoded);
    } catch (e, st) {
      Utils.logError('$e\n$st', name: 'Network Failure');
      return left(NetworkFailure('Network Failure', e.toString()));
    }
  }

  // -------------------------------------------------------------------------
  // Helper: Multipart request (POST / PATCH / PUT)
  // -------------------------------------------------------------------------
  Future<Either<NetworkFailure, dynamic>> _multipartRequest({
    required String method,
    required String url,
    required Map<String, dynamic> data,
    required Map<String, dynamic> file,
    Map<String, String>? header,
    String? pathVariable,
  }) async {
    final uri = _buildUri(url, pathVariable: pathVariable);
    final headers = header ?? {};

    Utils.logInfo(uri.toString(), name: "$method Multipart URI");
    Utils.logInfo(headers.toString(), name: "$method Headers");
    Utils.logInfo(data.toString(), name: "$method Data");
    Utils.logInfo(file.toString(), name: "$method Files");

    try {
      final request = http.MultipartRequest(method, uri)
        ..headers.addAll(headers);

      // Add text fields
      data.forEach((k, v) {
        request.fields[k] = v is List ? jsonEncode(v) : v.toString();
      });

      // Add files (supports single file or list of files per key)
      if (file.isNotEmpty) {
        await Future.forEach(file.entries, (
          MapEntry<String, dynamic> entry,
        ) async {
          final key = entry.key;
          final value = entry.value;

          if (value is List && value.isNotEmpty) {
            for (final path in value.cast<String>()) {
              if (path.isNotEmpty) {
                request.files.add(await _multipartFile(key, path));
              }
            }
          } else if (value is String && value.isNotEmpty) {
            request.files.add(await _multipartFile(key, value));
          }
        });
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      final failure = _handleError(response);
      if (failure != null) return left(failure);

      final decoded = _decodeBody(response);
      Utils.logInfo(decoded.toString(), name: "$method Multipart Response");
      return right(decoded);
    } catch (e, st) {
      Utils.logError('$e\n$st', name: 'Network Failure');
      return left(NetworkFailure('Network Failure', e.toString()));
    }
  }

  Future<http.MultipartFile> _multipartFile(
    String field,
    String filePath,
  ) async {
    final fileName = filePath.split('/').last;
    final contentType = _mediaType(filePath);
    return http.MultipartFile.fromPath(
      field,
      filePath,
      filename: fileName,
      contentType: contentType,
    );
  }

  // -------------------------------------------------------------------------
  // Public API – Header is now optional
  // -------------------------------------------------------------------------
  @override
  Future<Either<NetworkFailure, dynamic>> get(
    String url,
    Map<String, String>? header, {
    Map<String, dynamic>? query,
    String? pathVariable,
  }) => _request(
    method: 'GET',
    url: url,
    header: header,
    query: query,
    pathVariable: pathVariable,
  );

  @override
  Future<Either<NetworkFailure, dynamic>> post(
    String url,
    Map<String, dynamic> data,
    Map<String, String>? header, {
    String? pathVariable,
  }) => _request(
    method: 'POST',
    url: url,
    body: data,
    header: header,
    pathVariable: pathVariable,
  );

  @override
  Future<Either<NetworkFailure, dynamic>> patch(
    String url,
    Map<String, dynamic> data,
    Map<String, String>? header, {
    String? pathVariable,
  }) => _request(
    method: 'PATCH',
    url: url,
    body: data,
    header: header,
    pathVariable: pathVariable,
  );

  @override
  Future<Either<NetworkFailure, dynamic>> put(
    String url,
    Map<String, dynamic> data,
    Map<String, String>? header, {
    String? pathVariable,
  }) => _request(
    method: 'PUT',
    url: url,
    body: data,
    header: header,
    pathVariable: pathVariable,
  );

  @override
  Future<Either<NetworkFailure, dynamic>> postFile(
    String url,
    Map<String, dynamic> data,
    Map<String, dynamic> file,
    Map<String, String>? header, {
    String? pathVariable,
  }) => _multipartRequest(
    method: 'POST',
    url: url,
    data: data,
    file: file,
    header: header,
    pathVariable: pathVariable,
  );

  @override
  Future<Either<NetworkFailure, dynamic>> patchFile(
    String url,
    Map<String, dynamic> data,
    Map<String, dynamic> file,
    Map<String, String>? header, {
    String? pathVariable,
  }) => _multipartRequest(
    method: 'PATCH',
    url: url,
    data: data,
    file: file,
    header: header,
    pathVariable: pathVariable,
  );

  @override
  Future<Either<NetworkFailure, dynamic>> putFile(
    String url,
    Map<String, dynamic> data,
    Map<String, dynamic> file,
    Map<String, String>? header, {
    String? pathVariable,
  }) => _multipartRequest(
    method: 'PUT',
    url: url,
    data: data,
    file: file,
    header: header,
    pathVariable: pathVariable,
  );

  @override
  Future<Either<NetworkFailure, dynamic>> delete(
    String url,
    Map<String, String>? header, {
    Map<String, dynamic>? query,
    String? pathVariable,
  }) => _request(
    method: 'DELETE',
    url: url,
    header: header,
    query: query,
    pathVariable: pathVariable,
  );

  // -------------------------------------------------------------------------
  // Private utilities
  // -------------------------------------------------------------------------
  http.MediaType _mediaType(String filePath) {
    final ext = filePath.split('.').last.toLowerCase();
    return switch (ext) {
      'pdf' => http.MediaType('application', 'pdf'),
      'json' => http.MediaType('application', 'json'),
      'txt' => http.MediaType('text', 'plain'),
      _ => http.MediaType('image', ext),
    };
  }

  NetworkFailure? _handleError(http.Response response) {
    final status = response.statusCode;
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : {};
    if (status != 200 && status != 201 && status != 202) {
      Utils.logError(body.toString(), name: 'Network HandleError');
    }

    String? message() =>
        (body is Map && body.containsKey('message')) ? body['message'] : null;

    return switch (status) {
      200 || 201 || 202 => null,
      400 => BadRequestFailure(message()),
      401 => UnAuthorizedFailure(message()),
      403 => Forbidden(message()),
      404 => NotFoundFailure(message()),
      405 => MethodNotAllowed(message()),
      408 => RequestTimeoutFailure(message()),
      409 => ConflictFailure(message()),
      413 => PayloadTooLarge(message()),
      415 => UnsupportedMediaType(message()),
      422 => UnprocessableEntity(message()),
      500 => ServerFailure(message()),
      502 => BadGateway(message()),
      504 => RequestTimeoutFailure(message()),
      _ => NetworkFailure(message() ?? 'Something went wrong'),
    };
  }

  dynamic _decodeBody(http.Response response) {
    if (response.body.isEmpty) return {};
    try {
      return jsonDecode(response.body);
    } catch (_) {
      return response.body; // fallback for plain text
    }
  }
}
