import 'package:app/localizations.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/error_manager.dart';
import 'package:utils/utils.dart';

sealed class AppError {
  const AppError();

  /// Title of the error which is visible to user.
  String title();

  /// Log error with [Logger].
  void logError(Logger log);
}

// API errors

sealed class ApiError extends AppError {
  const ApiError();

  @override
  String title() => R.strings.snackbar_error_api;
}

sealed class ActionApiError extends ApiError {
  const ActionApiError();

  /// Is status code HTTP 429
  bool isTooManyRequests() {
    return false;
  }
}

class ActionApiErrorException extends ActionApiError {
  final ApiException e;
  final StackTrace? stackTrace;
  const ActionApiErrorException(this.e, {this.stackTrace});

  @override
  bool isTooManyRequests() {
    return e.code == 429;
  }

  @override
  void logError(Logger log) {
    // HTTP 429 Too Many Requests
    if (e.code == 429) {
      showSnackBar(R.strings.snackbar_api_usage_limit_reached);
    } else {
      log.error("Action API error, code: ${e.code}", null, stackTrace);
      log.fine(e.toString());
      ErrorManager.getInstance().show(this);
    }
  }
}

class ActionApiErrorUnknownException extends ActionApiError {
  final StackTrace? stackTrace;
  const ActionApiErrorUnknownException({this.stackTrace});

  @override
  void logError(Logger log) {
    log.error("Action API returned unknown exception", null, stackTrace);
    ErrorManager.getInstance().show(this);
  }
}

class ActionApiTimeoutError extends ActionApiError {
  final StackTrace? stackTrace;
  const ActionApiTimeoutError({this.stackTrace});

  @override
  String title() => R.strings.snackbar_error_api_timeout;

  @override
  void logError(Logger log) {
    log.error("Action API request timed out", null, stackTrace);
    ErrorManager.getInstance().show(this);
  }
}

sealed class ValueApiError extends ApiError {
  const ValueApiError();

  /// Is status code HTTP 304
  bool isNotModified() {
    return false;
  }

  /// Is status code HTTP 401
  bool isUnauthorized() {
    return false;
  }

  /// Is status code HTTP 404
  bool isNotFoundError() {
    return false;
  }

  /// Is status code HTTP 500
  bool isInternalServerError() {
    return false;
  }

  /// Is status code HTTP 429
  bool isTooManyRequests() {
    return false;
  }
}

class NullError extends ValueApiError {
  final StackTrace? stackTrace;
  const NullError({this.stackTrace});

  @override
  void logError(Logger log) {
    log.error("API function returned null", null, stackTrace);
    ErrorManager.getInstance().show(this);
  }
}

class ValueApiUnknownException extends ValueApiError {
  final StackTrace? stackTrace;
  const ValueApiUnknownException({this.stackTrace});

  @override
  void logError(Logger log) {
    log.error("API function returned unknown exception", null, stackTrace);
    ErrorManager.getInstance().show(this);
  }
}

class ValueApiTimeoutError extends ValueApiError {
  final StackTrace? stackTrace;
  const ValueApiTimeoutError({this.stackTrace});

  @override
  String title() => R.strings.snackbar_error_api_timeout;

  @override
  void logError(Logger log) {
    log.error("Value API request timed out", null, stackTrace);
    ErrorManager.getInstance().show(this);
  }
}

class ValueApiException extends ValueApiError {
  final ApiException e;
  final StackTrace? stackTrace;
  const ValueApiException(this.e, {this.stackTrace});

  @override
  bool isNotModified() {
    return e.code == 304;
  }

  @override
  bool isUnauthorized() {
    return e.code == 401;
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
  bool isTooManyRequests() {
    return e.code == 429;
  }

  @override
  void logError(Logger log) {
    // HTTP 429 Too Many Requests
    if (e.code == 429) {
      showSnackBar(R.strings.snackbar_api_usage_limit_reached);
    } else {
      log.error("Value API error, code: ${e.code}", null, stackTrace);
      log.fine(e.toString());
      ErrorManager.getInstance().show(this);
    }
  }
}

class FileError extends AppError {
  const FileError();

  @override
  String title() => R.strings.snackbar_error_file;

  @override
  void logError(Logger log) {}
}

sealed class DatabaseError extends AppError {
  const DatabaseError();

  @override
  String title() => R.strings.snackbar_error_database;
}

class DatabaseException extends DatabaseError {
  final Exception e;
  final StackTrace? stackTrace;
  const DatabaseException(this.e, {this.stackTrace});

  @override
  void logError(Logger log) {
    log.error("Database exception: ${e.runtimeType}", null, stackTrace);
    log.fine(e.toString());
    ErrorManager.getInstance().show(this);
  }
}

class MissingAccountId extends DatabaseError {
  final StackTrace? stackTrace;
  const MissingAccountId({this.stackTrace});

  @override
  void logError(Logger log) {
    log.error("Database error: missing account ID", null, stackTrace);

    ErrorManager.getInstance().show(this);
  }
}

class MissingRequiredValue extends DatabaseError {
  final StackTrace? stackTrace;
  const MissingRequiredValue({this.stackTrace});

  @override
  void logError(Logger log) {
    log.error("Database error: missing required value", null, stackTrace);

    ErrorManager.getInstance().show(this);
  }
}

sealed class LogicError extends AppError {
  const LogicError();

  @override
  String title() => R.strings.snackbar_error_logic;
}

class MissingValue extends LogicError {
  final StackTrace? stackTrace;
  const MissingValue({this.stackTrace});

  @override
  void logError(Logger log) {
    log.error("Logic error: missing value", null, stackTrace);

    ErrorManager.getInstance().show(this);
  }
}
