import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioErrorManager {
  static Widget dioError(Object error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError) {
        return const Text('Connection Error');
      } else if (error.type == DioExceptionType.connectionTimeout) {
        return const Text('Connection Error');
      } else {
        return const Text('Error');
      }
    } else {
      return const Text('Error');
    }
  }
}
