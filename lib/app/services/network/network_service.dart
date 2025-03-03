import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/usecase/result.dart';
import '../../config/app_config.dart';
import 'logging_interceptor.dart';

final networkServiceProvider = Provider<NetworkService>((ref) {
  return NetworkService();
});

enum HttpMethod {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
}

class NetworkService {
  late Dio _dio;
  late BaseOptions _options;

  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService({String? url}) {
    _instance._options = BaseOptions(
      baseUrl: url ?? AppConfig.baseUrl,
    );

    _instance._dio = Dio(_instance._options);

    if (kDebugMode) {
      _instance._dio.interceptors.add(LoggingInterceptor());
    }

    return _instance;
  }

  NetworkService._internal();

  Map<String, dynamic> _buildHeaders(
    bool authRequired,
    Map<String, dynamic>? additionalHeaders,
  ) {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (additionalHeaders != null) ...additionalHeaders,
    };
  }

  Map<String, dynamic>? _filterQueryParameters(
    Map<String, dynamic>? queryParameters,
  ) {
    if (queryParameters == null) return null;
    return queryParameters..removeWhere((key, value) => value == null);
  }

  Future<Result<T>> sendRequest<T>({
    required String endpoint,
    required HttpMethod method,
    T Function(dynamic json)? parser,
    dynamic data,
    bool authRequired = true,
    Map<String, dynamic>? additionalHeaders,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final options = Options(
        method: method.name,
        headers: _buildHeaders(authRequired, additionalHeaders),
      );

      final params = _filterQueryParameters(queryParameters);

      final response = await _dio.request(
        endpoint,
        data: data,
        queryParameters: params,
        options: options,
      );

      return Result.fromResponse(response, parser);
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        return Result.error(
          message: dioError.response?.data.toString(),
          statusCode: dioError.response?.statusCode,
        );
      } else {
        return Result.error(
          message: dioError.message,
        );
      }
    } catch (e) {
      return Result.error(
        message: e.toString(),
      );
    }
  }
}
