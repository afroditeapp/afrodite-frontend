



import 'package:async/async.dart' show StreamExtensions;
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/utils/app_error.dart';
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
        const err = NullError();
        if (logError) {
          err.logError(log);
        }
        return const Err(err);
      } else {
        return Ok(value);
      }
    } on ApiException catch (e) {
      await handleApiUnauthorizedError(e);
      final err = ValueApiException(e);
      if (logError) {
        err.logError(log);
      }
      return Err(err);
    }
  }

  /// Handle ApiException.
  Future<Result<void, ActionApiError>> requestAction(Future<void> Function(T) action, {bool logError = true}) async {
    try {
      return Ok(await action(api));
    } on ApiException catch (e) {
      await handleApiUnauthorizedError(e);
      final err = ActionApiError(e);
      if (logError) {
        err.logError(log);
      }
      return Err(err);
    }
  }

  Future<void> handleApiUnauthorizedError(ApiException e) async {
    // HTTP 401 Unauthorized
    if (e.code != 401) {
      return;
    }

    final currentState = await ApiManager.getInstance().state.firstOrNull;
    if (currentState == ApiManagerState.connected) {
      log.warning("Current connection might be broken");
      ApiManager.getInstance().pingCurrentConnection();
    }
  }
}
