import 'dart:async';
import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_app/core/failures/network_failure.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'network.dart';

typedef AccessTokenReader = String Function();
typedef RefreshAccessToken = Future<String?> Function();
typedef ClearSession = Future<void> Function();

class NetworkService extends Network {
  final http.Client _client;
  AccessTokenReader? _currentAccessTokenReader;
  RefreshAccessToken? _refreshAccessTokenCallback;
  ClearSession? _clearSession;
  Future<String?>? _refreshInFlight;

  NetworkService({http.Client? client}) : _client = client ?? http.Client();

  void configureAuthRefresh({
    required AccessTokenReader getAccessToken,
    required RefreshAccessToken refreshAccessToken,
    required ClearSession clearSession,
  }) {
    _currentAccessTokenReader = getAccessToken;
    _refreshAccessTokenCallback = refreshAccessToken;
    _clearSession = clearSession;
  }

  void clearAuthRefreshConfig() {
    _currentAccessTokenReader = null;
    _refreshAccessTokenCallback = null;
    _clearSession = null;
    _refreshInFlight = null;
  }

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
        ? uri.replace(queryParameters: _normalizeQueryParameters(query))
        : uri;
  }

  Map<String, String> _normalizeQueryParameters(Map<String, dynamic> query) {
    final normalized = <String, String>{};

    query.forEach((key, value) {
      if (value == null) return;

      if (value is Iterable) {
        final items = value
            .where((item) => item != null)
            .map((item) => item.toString())
            .toList();
        if (items.isNotEmpty) {
          normalized[key] = items.join(',');
        }
        return;
      }

      normalized[key] = value.toString();
    });

    return normalized;
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
    bool canRetryAuth = true,
  }) async {
    final uri = _buildUri(url, pathVariable: pathVariable, query: query);
    final headers = _normalizeHeaders(header);

    Utils.logInfo(uri.toString(), name: "$method URI");
    Utils.logInfo(headers.toString(), name: "$method Headers");
    if (body != null) Utils.logInfo(body.toString(), name: "$method Body");

    try {
      final response = await _sendRequest(
        method: method,
        uri: uri,
        headers: headers,
        body: body,
      );

      final failure = _handleError(response);
      if (failure != null) {
        if (canRetryAuth && await _shouldAttemptRefresh(failure, headers)) {
          final newAccessToken = await _runRefreshFlow();
          if (newAccessToken != null && newAccessToken.isNotEmpty) {
            return _request(
              method: method,
              url: url,
              body: body,
              header: _withUpdatedAuthorization(headers, newAccessToken),
              query: query,
              pathVariable: pathVariable,
              canRetryAuth: false,
            );
          }
        }
        return left(failure);
      }

      final decoded = _decodeBody(response);
      Utils.logInfo(decoded.toString(), name: "$method Response");
      return right(decoded);
    } catch (e, st) {
      Utils.logError('$e\n$st', name: 'Network Failure');
      return left(NetworkFailure('Network Failure', e.toString()));
    }
  }

  Future<http.Response> _sendRequest({
    required String method,
    required Uri uri,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
  }) async {
    Future<http.Response> send() => switch (method) {
      'GET' => _client.get(uri, headers: headers),
      'POST' => body == null
          ? _client.post(uri, headers: headers)
          : _client.post(uri, headers: headers, body: jsonEncode(body)),
      'PATCH' => body == null
          ? _client.patch(uri, headers: headers)
          : _client.patch(uri, headers: headers, body: jsonEncode(body)),
      'PUT' => body == null
          ? _client.put(uri, headers: headers)
          : _client.put(uri, headers: headers, body: jsonEncode(body)),
      'DELETE' => _client.delete(uri, headers: headers),
      _ => throw UnimplementedError('HTTP method $method not supported'),
    };

    try {
      return await send().timeout(const Duration(seconds: 30));
    } on http.ClientException {
      if (method != 'GET') rethrow;
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return send().timeout(const Duration(seconds: 30));
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
    bool canRetryAuth = true,
  }) async {
    final uri = _buildUri(url, pathVariable: pathVariable);
    final headers = _normalizeHeaders(header);

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
      if (failure != null) {
        if (canRetryAuth && await _shouldAttemptRefresh(failure, headers)) {
          final newAccessToken = await _runRefreshFlow();
          if (newAccessToken != null && newAccessToken.isNotEmpty) {
            return _multipartRequest(
              method: method,
              url: url,
              data: data,
              file: file,
              header: _withUpdatedAuthorization(headers, newAccessToken),
              pathVariable: pathVariable,
              canRetryAuth: false,
            );
          }
        }
        return left(failure);
      }

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

  Future<Either<NetworkFailure, dynamic>> postWithoutBody(
    String url,
    Map<String, String>? header, {
    String? pathVariable,
  }) => _request(
    method: 'POST',
    url: url,
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
    final body = _decodeBody(response);
    if (status != 200 && status != 201 && status != 202) {
      Utils.logError(body.toString(), name: 'Network HandleError');
    }

    String? message() {
      if (body is Map && body.containsKey('message')) {
        return body['message']?.toString();
      }

      if (body is String && body.trim().isNotEmpty) {
        final normalized = body.trim();
        if (normalized.startsWith('<!DOCTYPE html') || normalized.startsWith('<html')) {
          return 'Server returned HTML instead of JSON';
        }
        return normalized;
      }

      return null;
    }

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

  Map<String, String> _normalizeHeaders(Map<String, String>? header) {
    final headers = Map<String, String>.from(header ?? {});
    final hasAuthorization = headers.containsKey('Authorization');
    final latestAccessToken = _currentAccessTokenReader?.call() ?? '';

    if (hasAuthorization && latestAccessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $latestAccessToken';
    }

    return headers;
  }

  Future<bool> _shouldAttemptRefresh(
    NetworkFailure failure,
    Map<String, String> headers,
  ) async {
    if (_refreshAccessTokenCallback == null) return false;

    final authHeader = headers['Authorization'];
    if (authHeader == null || authHeader.isEmpty) return false;

    return failure is UnAuthorizedFailure;
  }

  Future<String?> _runRefreshFlow() async {
    if (_refreshAccessTokenCallback == null) return null;

    if (_refreshInFlight != null) {
      return _refreshInFlight;
    }

    final completer = Completer<String?>();
    _refreshInFlight = completer.future;

    try {
      Utils.logInfo('Refreshing access token', name: 'NetworkService');
      final newAccessToken = await _refreshAccessTokenCallback!.call();

      if (newAccessToken == null || newAccessToken.isEmpty) {
        await _clearSession?.call();
        completer.complete(null);
        return null;
      }

      completer.complete(newAccessToken);
      return newAccessToken;
    } catch (e, st) {
      Utils.logError('$e\n$st', name: 'Token Refresh Failure');
      await _clearSession?.call();
      completer.complete(null);
      return null;
    } finally {
      _refreshInFlight = null;
    }
  }

  Map<String, String> _withUpdatedAuthorization(
    Map<String, String> headers,
    String accessToken,
  ) {
    return {
      ...headers,
      'Authorization': 'Bearer $accessToken',
    };
  }
}
