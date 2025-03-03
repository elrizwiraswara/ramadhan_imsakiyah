import 'package:dio/dio.dart';

import '../../utilities/console_log.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    cl(
      '[onRequest]\n' +
          'Method   : ${options.method}\n' +
          'Path     : ${options.baseUrl}${options.path}\n' +
          'Headers  : ${jsonPrettier(options.headers)}\n' +
          'Params   : ${jsonPrettier(options.queryParameters)}\n' +
          'Body     : ${jsonPrettier(options.data)}',
      type: LogType.info,
    );

    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    cl(
      '[onError]\n' +
          'Method   : ${err.response?.requestOptions.method}\n' +
          'Path     : ${err.response?.requestOptions.baseUrl}${err.response?.requestOptions.path}\n' +
          'Headers  : ${jsonPrettier(err.response?.requestOptions.headers)}\n' +
          'Params   : ${jsonPrettier(err.response?.requestOptions.queryParameters)}\n' +
          'Body     : ${jsonPrettier(err.response?.requestOptions.data)}\n' +
          'Status   : ${err.response?.statusCode}\n' +
          'Response : ${jsonPrettier(err.response?.data)}\n' +
          'Message  : ${err.message}',
      type: LogType.error,
    );

    handler.next(err);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    cl(
      '[onResponse]\n' +
          'Method   : ${response.requestOptions.method}\n' +
          'Path     : ${response.requestOptions.baseUrl}${response.requestOptions.path}\n' +
          'Headers  : ${jsonPrettier(response.requestOptions.headers)}\n' +
          'Params   : ${jsonPrettier(response.requestOptions.queryParameters)}\n' +
          'Body     : ${jsonPrettier(response.requestOptions.data)}\n' +
          'Code     : ${response.statusCode}\n' +
          'Response : ${jsonPrettier(response.data)}',
      type: LogType.info,
    );

    handler.next(response);
  }
}
