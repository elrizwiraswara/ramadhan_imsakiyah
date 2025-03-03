import 'package:dio/dio.dart';

import '../errors/exceptions.dart';

enum Status {
  ok,
  unauthorized,
  error,
}

class Result<T> {
  final Status? status;
  final int? statusCode;
  final T? data;
  final String? message;

  Result._({
    this.status,
    this.statusCode,
    this.data,
    this.message,
  });

  factory Result.fromResponse(
    Response response,
    T Function(dynamic)? parser,
  ) {
    final dataResponse = response.data;
    final isSuccess = response.statusCode == 200 || response.statusCode == 201;

    /// Format of the response:
    /// {
    ///     'code': 200,
    ///     'message': 'Data retrieved successfully'
    ///     'data': null
    /// }

    if (isSuccess) {
      return Result._(
        status: Status.ok,
        statusCode: response.statusCode,
        message: dataResponse['message'],
        data: parser != null ? parser(dataResponse['data']) : dataResponse,
      );
    } else if (response.statusCode == 401) {
      return Result._(
        status: Status.unauthorized,
        message: 'You are not authorized to perform this action.',
      );
    } else {
      throw BusinessException.fromJson(dataResponse);
    }
  }

  Result.ok({
    this.message,
    this.data,
    this.statusCode,
  }) : status = Status.ok;

  Result.error({
    this.message,
    this.data,
    this.statusCode,
  }) : status = Status.error;
}
