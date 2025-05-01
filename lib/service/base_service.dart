import 'dart:async';
import 'dart:convert';

import 'package:debug_logger/debug_logger.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/models/retry_policy.dart';
import 'package:http_parser/http_parser.dart';
import 'package:playground/service/response/error_response.dart';
import 'package:playground/service/network_error.dart';

abstract class BaseService {
  String get commonApiUrl {
    return "https://api.github.com/";
  }

  late final InterceptedClient _client = InterceptedClient.build(
    interceptors: [
      _LoggerInterceptor(),
    ],
    retryPolicy: _ExpiredTokenRetryPolicy(),
  );

  Future<Map<String, dynamic>> get<T extends JsonSerializer>(String url,
      {Map<String, String>? headers, Map<String, dynamic>? params}) async {
    final response = await _client.get(Uri.parse(url),
        headers: _baseHeaders(headers: headers),
        params: params?..removeWhere((key, value) => value == null));

    return response._result();
  }

  Future<Map<String, dynamic>> post<T extends JsonSerializer>(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? params,
      Object? body,
      Encoding? encoding}) async {
    final response = await _client.post(Uri.parse(url),
        headers: _baseHeaders(headers: headers),
        body: _encodeBody(body),
        encoding: encoding,
        params: params);

    return response._result();
  }

  Future<Map<String, dynamic>> put<T extends JsonSerializer>(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? params,
      Object? body,
      Encoding? encoding}) async {
    final response = await _client.put(Uri.parse(url),
        headers: _baseHeaders(headers: headers),
        body: _encodeBody(body),
        encoding: encoding);

    return response._result();
  }

  Future<Map<String, dynamic>> delete<T extends JsonSerializer>(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? params,
      Object? body,
      Encoding? encoding}) async {
    final response = await _client.delete(Uri.parse(url),
        headers: _baseHeaders(headers: headers),
        body: _encodeBody(body),
        encoding: encoding);

    return response._result();
  }

  Future<Map<String, dynamic>> multipartRequest<T extends JsonSerializer>(
      String url,
      {required List<MultiPartFileData> files,
      Map<String, String>? headers}) async {
    final request = http.MultipartRequest('POST', Uri.parse(url));

    List<http.MultipartFile> multipartFiles = await Future.wait(files.map(
        (data) => http.MultipartFile.fromPath(data.field, data.filePath,
            contentType: data.contentType)));

    request.headers.addAll(headers ?? {});
    request.files.addAll(multipartFiles);

    DebugLogger.info("----- Request -----\n" +
        "method : ${request.method}\n" +
        "url : ${request.url}");
    http.StreamedResponse streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    DebugLogger.info("----- Response -----\n" +
        "statusCode : ${response.statusCode}\n" +
        "body : ${response.body}");
    return response._result();
  }

  Map<String, String> _baseHeaders({Map<String, String>? headers}) {
    return <String, String>{"Content-Type": "application/json"}
      ..addAll(headers ?? <String, String>{});
  }

  Object? _encodeBody(Object? object) {
    if (object == null) {
      return null;
    } else if (object is JsonSerializer) {
      return jsonEncode(object.toJson());
    } else if (object is Map<String, dynamic>) {
      return jsonEncode(object);
    } else {
      return object;
    }
  }
}

class MultiPartFileData {
  final String field;
  final String filePath;
  final MediaType? contentType;

  MultiPartFileData(this.field, this.filePath, {this.contentType});
}

class _LoggerInterceptor implements InterceptorContract {
  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }

  @override
  FutureOr<http.BaseRequest> interceptRequest(
      {required http.BaseRequest request}) {
    DebugLogger.info("----- Request -----\n" +
        'method : ${request.method}\n' +
        'url : ${request.url}\n' +
        'headers : ${request.headers}');
    return request;
  }

  @override
  FutureOr<http.BaseResponse> interceptResponse(
      {required http.BaseResponse response}) {
    DebugLogger.info("----- Response -----\n" +
        'method : ${response.request?.method}\n' +
        'url : ${response.request?.url}\n' +
        'headers : ${response.headers}\n' +
        'statusCode : ${response.statusCode}');
    return response;
  }
}

class _ExpiredTokenRetryPolicy extends RetryPolicy {
  final int _UNAUTHORIZED_TOKEN = 401;

  @override
  int get maxRetryAttempts => 2;

  @override
  bool shouldAttemptRetryOnException(Exception reason, BaseRequest request) {
    DebugLogger.error(reason);

    return false;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode == _UNAUTHORIZED_TOKEN) {
      DebugLogger.info("Retrying request...");

      return true;
    }

    return false;
  }
}

extension ResponseExtension on http.Response {
  Map<String, dynamic> _result() {
    const int _SUCCESS = 200;
    if (statusCode == _SUCCESS) {
      return const JsonDecoder().convert(body.isNotEmpty ? body : "{}");
    } else {
      throw NetworkError(statusCode,
          ErrorResponse.fromJson(const JsonDecoder().convert(body)));
    }
  }
}

abstract class JsonSerializer {
  JsonSerializer.fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toJson();

  @override
  String toString() {
    return toJson().toString();
  }
}
