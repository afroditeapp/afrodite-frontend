


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
        ErrorManager.getInstance().send(ApiError());
      }
      rethrow;
    }
  }

  Future<(int?, R?)> requestWithHttpStatus<R extends Object>(bool logError, Future<R?> Function(T) action) async {
    try {
      final result = await action(api);
      if (result != null) {
        return (200, result);
      } else {
        return (null, null);
      }
    } on ApiException catch (e) {
      if (logError) {
        log.error(e);
        ErrorManager.getInstance().send(ApiError());
      }
      return (e.code, null);
    }
  }
}
