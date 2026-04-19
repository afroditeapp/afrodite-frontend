import 'dart:async';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';

final _log = Logger("ApiWrapper");

class ApiWrapper<T> {
  final T api;
  final ServerConnectionInterface serverConnection;

  ApiWrapper(this.api, this.serverConnection);

  /// Handle ApiException.
  Future<Result<R, ValueApiError>> requestValue<R extends Object>(
    Future<R?> Function(T) action, {
    Duration timeout = const Duration(seconds: 10),
    bool logError = true,
  }) async {
    try {
      final value = await action(api).timeout(timeout);

      if (value == null) {
        const err = NullError();
        if (logError) {
          err.logError(_log);
        }
        return const Err(err);
      } else {
        return Ok(value);
      }
    } on ApiException catch (e, stackTrace) {
      await restartConnectionIfNeeded(e);
      final err = ValueApiException(e, stackTrace: stackTrace);
      if (logError) {
        err.logError(_log);
      }
      return Err(err);
    } on TimeoutException catch (_, stackTrace) {
      final err = ValueApiTimeoutError(stackTrace: stackTrace);
      if (logError) {
        err.logError(_log);
      }
      return Err(err);
    } catch (_, stackTrace) {
      final err = ValueApiUnknownException(stackTrace: stackTrace);
      err.logError(_log);
      return Err(err);
    }
  }

  /// Handle ApiException.
  Future<Result<(), ActionApiError>> requestAction(
    Future<void> Function(T) action, {
    Duration timeout = const Duration(seconds: 10),
    bool logError = true,
  }) async {
    try {
      await action(api).timeout(timeout);
      return Ok(());
    } on ApiException catch (e, stackTrace) {
      await restartConnectionIfNeeded(e);
      final err = ActionApiErrorException(e, stackTrace: stackTrace);
      if (logError) {
        err.logError(_log);
      }
      return Err(err);
    } on TimeoutException catch (_, stackTrace) {
      final err = ActionApiTimeoutError(stackTrace: stackTrace);
      if (logError) {
        err.logError(_log);
      }
      return Err(err);
    } catch (_, stackTrace) {
      final err = ActionApiErrorUnknownException(stackTrace: stackTrace);
      err.logError(_log);
      return Err(err);
    }
  }

  Future<void> restartConnectionIfNeeded(ApiException e) async {
    if (
    // HTTP 401 Unauthorized
    e.code == 401 ||
        // Current HTTP connection broke (and perhaps some other errors also)
        (e.code == 400 && e.innerException != null)) {
      if (serverConnection.isConnected) {
        _log.warning("Current connection might be broken");
        await serverConnection.restartIfRestartNotOngoing();
      }
    }
  }
}

abstract class ServerConnectionInterface {
  bool get isConnected;
  Future<void> restartIfRestartNotOngoing();
}

class NoConnection implements ServerConnectionInterface {
  @override
  bool get isConnected => false;

  @override
  Future<void> restartIfRestartNotOngoing() async {}
}
