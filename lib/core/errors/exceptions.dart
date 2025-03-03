import 'dart:convert';

import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  String? header;
  String? state;
  String? message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioExceptionType.unknown:
        message = 'Connection to API server failed due to internet connection';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
        break;
      case DioExceptionType.badResponse:
        header = dioError.response?.data['message']['header'];
        state = dioError.response?.data['message']['state'];
        message = dioError.response?.data['message']['body'];
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      default:
        message = 'Something went wrong';
        break;
    }
  }
}

class BusinessException {
  BusinessException({
    this.title,
    this.state,
    this.message,
    this.data,
  });

  factory BusinessException.fromJson(Map<String, dynamic> json) =>
      BusinessException(
        title: json['message']['header'],
        state: json['message']['state'],
        message: json['message']['body'],
        data: json['data'] as String?,
      );

  final String? title;
  final String? state;
  final String? message;
  final String? data;

  @override
  String toString() {
    return 'Business Exception :\n${jsonEncode(
      {
        'title': title,
        'state': state,
        'message': message,
        'data': data,
      },
    )}';
  }
}
