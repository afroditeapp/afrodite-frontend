

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

sealed class ActionApiError extends ApiError {
  const ActionApiError();
}

class ActionApiErrorException extends ActionApiError {
  final ApiException e;
  const ActionApiErrorException(this.e);

  @override
  void logError(Logger log) {
    log.error("Action API error, code: ${e.code}");
    log.fine(StackTrace.current);
    ErrorManager.getInstance().show(this);
  }
}

class ActionApiErrorUnknownException extends ActionApiError {
  const ActionApiErrorUnknownException();

  @override
  void logError(Logger log) {
    log.error("Action API returned unknown exception");
    log.fine(StackTrace.current);
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
    log.fine(StackTrace.current);
    ErrorManager.getInstance().show(this);
  }
}

class ValueApiUnknownException extends ValueApiError {
  const ValueApiUnknownException();

  @override
  void logError(Logger log) {
    log.error("API function returned unknown exception");
    log.fine(StackTrace.current);
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
    log.error("Value API error, code: ${e.code}");
    log.fine(StackTrace.current);
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
    log.error("Database exception");
    log.fine(e);
    log.fine(StackTrace.current);
    ErrorManager.getInstance().show(this);
  }
}

class MissingAccountId extends DatabaseError {
  const MissingAccountId();

  @override
  void logError(Logger log) {
    log.error("Database error: missing account ID");
    log.fine(StackTrace.current);

    ErrorManager.getInstance().show(this);
  }
}

class MissingRequiredValue extends DatabaseError {
  const MissingRequiredValue();

  @override
  void logError(Logger log) {
    log.error("Database error: missing required value");
    log.fine(StackTrace.current);

    ErrorManager.getInstance().show(this);
  }
}

// TODO(prod): translate error titles

sealed class LogicError extends AppError {
  const LogicError();

  @override
  String title() => "Logic error";
}

class MissingValue extends LogicError {
  const MissingValue();

  @override
  void logError(Logger log) {
    log.error("Logic error: missing value");
    log.fine(StackTrace.current);

    ErrorManager.getInstance().show(this);
  }
}
