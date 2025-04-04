


import 'dart:async';

import 'package:app/api/api_manager.dart';
import 'package:app/utils/result.dart';
import 'package:utils/utils.dart';
import 'package:rxdart/rxdart.dart';

abstract class DataRepository extends AppSingleton implements DataRepositoryMethods {
  @override
  Future<void> onLogin() async {}
  @override
  Future<Result<void, void>> onLoginDataSync() async {
    return const Ok(null);
  }
  @override
  Future<void> onLogout() async {}
  @override
  Future<void> onResumeAppUsage() async {}
  @override
  Future<void> onInitialSetupComplete() async {}
}

abstract class DataRepositoryWithLifecycle implements DataRepositoryMethods, LifecycleMethods {
  @override
  Future<void> init() async {}
  @override
  Future<void> dispose() async {}

  @override
  Future<void> onLogin() async {}
  @override
  Future<Result<void, void>> onLoginDataSync() async {
    return const Ok(null);
  }
  @override
  Future<void> onLogout() async {}
  @override
  Future<void> onResumeAppUsage() async {}
  @override
  Future<void> onInitialSetupComplete() async {}
}

abstract class DataRepositoryMethods {
  /// Called when the user logs in. Note that this is not called
  /// every time the app is opened, but only when the user logs in.
  ///
  /// Server API is not available.
  Future<void> onLogin() async {}

  /// Called when the user logs in. Note that this is not called
  /// every time the app is opened, but only when the user logs in.
  ///
  /// It is not quaranteed that this is called as first failure in one
  /// repository will stop calling this method.
  ///
  /// Server API is available.
  Future<Result<void, void>> onLoginDataSync() async {
    return const Ok(null);
  }

  /// Called when the user logs out. Note that this is not called
  /// every time the app is closed, but only when the user logs out.
  ///
  /// Account specific database data clearing should not be required
  /// as if account is used on some other device, the tokens invalidate
  /// and new login is required (that forces data sync).
  ///
  /// Server API is not available.
  Future<void> onLogout() async {}

  /// Called when the user opens app and there has been previous
  /// login.
  ///
  /// Server API is not available.
  Future<void> onResumeAppUsage() async {}

  /// Called when initial setup is completed.
  ///
  /// Server API is available.
  Future<void> onInitialSetupComplete() async {}
}

abstract class LifecycleMethods {
  /// Initialize the object.
  Future<void> init() async {}

  /// Dispose the object.
  Future<void> dispose() async {}
}

class ConnectedActionScheduler {
  final ServerConnectionManager connectionManager;

  ConnectedActionScheduler(this.connectionManager);

  bool _onLoginScheduled = false;
  int _onLoginScheduledCount = 0;

  final BehaviorSubject<bool> _cancel = BehaviorSubject.seeded(false);

  Future<void> dispose() async {
    _cancel.add(true);
  }

  /// The onResumeAppUsageSync might be also still scheduled
  /// if there was connection token error.
  void onLoginSync(Future<void> Function() action) {
    _onLoginScheduledCount++;
    final count = _onLoginScheduledCount;
    _onLoginScheduled = true;

    Future.any<ApiManagerState?>([
      connectionManager
        .state
        .firstWhere((element) => element == ApiManagerState.connected),
      _cancel
        .firstWhere((v) => v)
        .then((v) => null)
    ])
      .then((value) async {
        if (value == null) {
          return;
        }

        if (count != _onLoginScheduledCount) {
          // Only do latest requested sync
          return;
        }
        await action();

        _onLoginScheduled = false;
      })
      .ignore();
  }

  void onResumeAppUsageSync(Future<void> Function() action) {
    Future.any<ApiManagerState?>([
      connectionManager
        .state
        .firstWhere((element) => element == ApiManagerState.connected),
      _cancel
        .firstWhere((v) => v)
        .then((v) => null)
    ])
      .then((value) async {
        if (value == null) {
          return;
        }

        if (_onLoginScheduled) {
          return;
        }
        await action();
      })
      .ignore();
  }
}
