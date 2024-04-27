

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/utils.dart';

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
  String title() => "API error";
}

class ActionApiError extends ApiError {
  final ApiException e;
  const ActionApiError(this.e);

  @override
  void logError(Logger log) {
    log.error(e);
    // TODO(prod): remove stack trace for production?
    log.error(StackTrace.current);
    ErrorManager.getInstance().show(this);
  }
}

sealed class ValueApiError extends ApiError {
  const ValueApiError();

  /// Is status code HTTP 304
  bool isNotModified() { return false; }

  /// Is status code HTTP 404
  bool isNotFoundError() { return false; }

  /// Is status code HTTP 500
  bool isInternalServerError() { return false; }
}

class NullError extends ValueApiError {
  const NullError();

  @override
  void logError(Logger log) {
    log.error("API function returned null");
    // TODO(prod): remove stack trace for production?
    log.error(StackTrace.current);
    ErrorManager.getInstance().show(this);
  }
}

class ValueApiException extends ValueApiError {
  final ApiException e;
  const ValueApiException(this.e);

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
  void logError(Logger log) {
    log.error(e);
    // TODO(prod): remove stack trace for production?
    log.error(StackTrace.current);
    ErrorManager.getInstance().show(this);
  }
}


class FileError extends AppError {
  const FileError();

  @override
  String title() => "File error";

  @override
  void logError(Logger log) {}
}

sealed class DatabaseError extends AppError {
  const DatabaseError();

  @override
  String title() => "Database error";
}

class DatabaseException extends DatabaseError {
  final Exception e;
  const DatabaseException(this.e);

  @override
  void logError(Logger log) {
    // TODO(prod): remove exception printing for production?
    log.error(e);
    // TODO(prod): remove stack trace for production?
    log.error(StackTrace.current);
    ErrorManager.getInstance().show(this);
  }
}

class MissingAccountId extends DatabaseError {
  const MissingAccountId();

  @override
  void logError(Logger log) {
    log.error(this);
    // TODO(prod): remove stack trace for production?
    log.error(StackTrace.current);
    ErrorManager.getInstance().show(this);
  }
}

class MissingRequiredValue extends DatabaseError {
  const MissingRequiredValue();

  @override
  void logError(Logger log) {
    log.error(this);
    // TODO(prod): remove stack trace for production?
    log.error(StackTrace.current);
    ErrorManager.getInstance().show(this);
  }
}
