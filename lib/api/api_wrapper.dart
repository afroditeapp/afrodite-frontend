



import 'package:async/async.dart' show StreamExtensions;
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';

final log = Logger("ApiWrapper");

class ApiWrapper<T> {
  final T api;
  final ServerConnectionInterface serverConnection;

  ApiWrapper(this.api, this.serverConnection);

  /// Handle ApiException.
  Future<Result<R, ValueApiError>> requestValue<R extends Object>(Future<R?> Function(T) action, {bool logError = true}) async {
    try {
      final value = await action(api);

      if (value == null) {
        const err = NullError();
        if (logError) {
          err.logError(log);
        }
        return const Err(err);
      } else {
        return Ok(value);
      }
    } on ApiException catch (e) {
      await restartConnectionIfNeeded(e);
      final err = ValueApiException(e);
      if (logError) {
        err.logError(log);
      }
      return Err(err);
    } catch (e) {
      const err = ValueApiUnknownException();
      err.logError(log);
      return const Err(err);
    }
  }

  /// Handle ApiException.
  Future<Result<(), ActionApiError>> requestAction(Future<void> Function(T) action, {bool logError = true}) async {
    try {
      await action(api);
      return Ok(());
    } on ApiException catch (e) {
      await restartConnectionIfNeeded(e);
      final err = ActionApiErrorException(e);
      if (logError) {
        err.logError(log);
      }
      return Err(err);
    } catch (e) {
      const err = ActionApiErrorUnknownException();
      err.logError(log);
      return const Err(err);
    }
  }

  Future<void> restartConnectionIfNeeded(ApiException e) async {
    if (
      // HTTP 401 Unauthorized
      e.code == 401 ||
      // Current HTTP connection broke (and perhaps some other errors also)
      (e.code == 400 && e.innerException != null)
    ) {
      final currentState = await serverConnection.state.firstOrNull;
      if (!_connectionRestartInProgress && currentState == ServerConnectionState.connected) {
        _connectionRestartInProgress = true;
        log.warning("Current connection might be broken");
        await serverConnection.restart();
        _connectionRestartInProgress = false;
      }
    }
  }
}

bool _connectionRestartInProgress = false;

abstract class ServerConnectionInterface {
  Stream<ServerConnectionState> get state;
  Future<void> restart();
}

class NoConnection implements ServerConnectionInterface {
  @override
  Stream<ServerConnectionState> get state => const Stream.empty();

  @override
  Future<void> restart() async {}
}
