import 'dart:async';
import 'dart:io';

import 'package:cats/data/exceptions/base_exception.dart';
import 'package:dio/dio.dart';

abstract class BaseErrorHandler {
  factory BaseErrorHandler() => _BaseErrorHandler();

  Future<T> handleError<T>(Object? error);
}

class _BaseErrorHandler implements BaseErrorHandler {
  @override
  Future<T> handleError<T>(Object? error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return _handleException(TimeoutException('Responding time has exceeded'));
      } else if (error.error is Exception) {
        return _handleException(error);
      } else {
        return Future.error(BaseException(message: 'Network exception'));
      }
    } else if (error is Exception) {
      return _handleException(error);
    } else {
      return Future.error(BaseException(message: 'unexpected exception'));
    }
  }

  Future<T> _handleException<T>(Exception error) {
    if (error is IOException) {
      return Future.error(BaseException(message: 'Network exception'));
    } else if (error is TimeoutException) {
      return Future.error(TimeoutException('Responding time has exceeded'));
    } else {
      return Future.error(error);
    }
  }
}
