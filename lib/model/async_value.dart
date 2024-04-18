import 'package:flutter/widgets.dart';
import 'package:order_tracker/utils/error_handling.dart';

enum AsyncStatus {
  loading,
  data,
  error,
}

class AsyncValue<T> {
  /// The current status of the asynchronous operation
  final AsyncStatus status;

  /// The data of the asynchronous operation (only available in data state)
  final T? data;

  /// The error of the asynchronous operation (only available in error state)
  final Object? error;

  /// The errormessage of the asynchronous operation (only available in error state)
  final String? message;

  AsyncValue._({
    required this.status,
    this.data,
    this.error,
    this.message,
  });

  factory AsyncValue.loading() {
    return AsyncValue._(
      status: AsyncStatus.loading,
    );
  }

  factory AsyncValue.data(T data) {
    return AsyncValue._(
      status: AsyncStatus.data,
      data: data,
    );
  }

  factory AsyncValue.error(Object error) {
    return AsyncValue._(
      status: AsyncStatus.error,
      error: error,
      message: AppError.getErrorMessage(error),
    );
  }

  /// Helper method to check if the current state is loading
  bool get isLoading => status == AsyncStatus.loading;

  /// Helper method to check if the current state is data
  bool get isdata => status == AsyncStatus.data;

  /// Helper method to check if the current state is error
  bool get isError => status == AsyncStatus.error;

  /// To handle different states
  Widget when({
    required Widget Function() isLoading,
    required Widget Function(T data) hasData,
    required Widget Function(String message) hasError,
  }) {
    switch (status) {
      case AsyncStatus.loading:
        return isLoading();
      case AsyncStatus.data:
        if (data != null) {
          return hasData(data as T);
        } else {
          throw StateError('Data is null in data state');
        }
      case AsyncStatus.error:
        return hasError(message as String);
    }
  }
}
