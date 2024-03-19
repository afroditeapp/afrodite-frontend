



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
        return Err(NullError());
      } else {
        return Ok(value);
      }
    } on ApiException catch (e) {
      if (logError) {
        log.error(e);
        // TODO(prod): remove stack trace for production?
        log.error(StackTrace.current);
        ErrorManager.getInstance().send(ApiError());
      }
      return Err(ValueApiException(e));
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

class ActionApiError {
  final ApiException e;
  ActionApiError(this.e);
}

sealed class ValueApiError {
  /// Is status code HTTP 404
  bool isNotFoundError() { return false; }

  /// Is status code HTTP 500
  bool isInternalServerError() { return false; }
}
class NullError extends ValueApiError {}
class ValueApiException extends ValueApiError {
  final ApiException e;
  ValueApiException(this.e);

  @override
  bool isNotFoundError() {
    return e.code == 404;
  }

  @override
  bool isInternalServerError() {
    return e.code == 500;
  }
}
