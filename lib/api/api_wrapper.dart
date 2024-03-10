



import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/utils.dart';

final log = Logger("ApiWrapper");

class ApiWrapper<T> {
  final T api;

  ApiWrapper(this.api);

  /// Handle ApiException.
  Future<R?> request<R extends Object>(Future<R?> Function(T) action) async {
    try {
      return await action(api);
    } on ApiException catch (e) {
      log.error(e);
      // TODO: remove stack trace for production?
      log.error(StackTrace.current);
      ErrorManager.getInstance().send(ApiError());
    }

    return null;
  }

  /// Rethrow ApiException.
  Future<R?> requestWithException<R extends Object>(bool logError, Future<R?> Function(T) action) async {
    try {
      return await action(api);
    } on ApiException catch (e) {
      if (logError) {
        log.error(e);
        // TODO: remove stack trace for production?
        log.error(StackTrace.current);
        ErrorManager.getInstance().send(ApiError());
      }
      rethrow;
    }
  }

  Future<(ApiHttpStatus, R?)> requestWithHttpStatus<R extends Object>(Future<R?> Function(T) action, {bool logError = true}) async {
    try {
      final result = await action(api);
      return (ApiHttpStatus(200), result);
    } on ApiException catch (e) {
      if (logError) {
        log.error(e);
        // TODO: remove stack trace for production?
        log.error(StackTrace.current);
        ErrorManager.getInstance().send(ApiError());
      }
      return (ApiHttpStatus(e.code), null);
    }
  }
}

class ApiHttpStatus {
  final int httpStatus;

  ApiHttpStatus(this.httpStatus);

  /// Is status code HTTP 200
  bool isSuccess() {
    return httpStatus == 200;
  }

  /// Is status code HTTP 500
  bool isInternalServerError() {
    return httpStatus == 500;
  }

  /// Is status code something other than HTTP 200
  bool isFailure() {
    return !isSuccess();
  }
}
