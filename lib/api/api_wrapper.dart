



import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';

final log = Logger("ApiWrapper");

// TODO(prod): make sure that error messages do not contain API paths
//             in production

class ApiWrapper<T> {
  final T api;

  ApiWrapper(this.api);

  /// Handle ApiException.
  Future<Result<R, ValueApiError>> requestValue<R extends Object>(Future<R?> Function(T) action, {bool logError = true}) async {
    try {
      final value = await action(api);

      if (value == null) {
        final err = NullError();
        if (logError) {
          err.logError();
        }
        return Err(err);
      } else {
        return Ok(value);
      }
    } on ApiException catch (e) {
      final err = ValueApiException(e);
      if (logError) {
        err.logError();
      }
      return Err(err);
    }
  }

  /// Handle ApiException.
  Future<Result<void, ActionApiError>> requestAction(Future<void> Function(T) action, {bool logError = true}) async {
    try {
      return Ok(await action(api));
    } on ApiException catch (e) {
      if (logError) {
        log.error(e);
        // TODO(prod): remove stack trace for production?
        log.error(StackTrace.current);
        ErrorManager.getInstance().send(ApiError());
      }
      return Err(ActionApiError(e));
    }
  }
}

class ActionApiError {
  final ApiException e;
  ActionApiError(this.e);
}

sealed class ValueApiError {
  /// Is status code HTTP 304
  bool isNotModified() { return false; }

  /// Is status code HTTP 404
  bool isNotFoundError() { return false; }

  /// Is status code HTTP 500
  bool isInternalServerError() { return false; }

  void logError() {}
}

class NullError extends ValueApiError {
  @override
  void logError() {
    log.error("API function returned null");
    // TODO(prod): remove stack trace for production?
    log.error(StackTrace.current);
    ErrorManager.getInstance().send(ApiError());
  }
}

class ValueApiException extends ValueApiError {
  final ApiException e;
  ValueApiException(this.e);

  @override
  bool isNotModified() {
    return e.code == 304;
  }

  @override
  bool isNotFoundError() {
    return e.code == 404;
  }

  @override
  bool isInternalServerError() {
    return e.code == 500;
  }

  @override
  void logError() {
    log.error(e);
    // TODO(prod): remove stack trace for production?
    log.error(StackTrace.current);
    ErrorManager.getInstance().send(ApiError());
  }
}
