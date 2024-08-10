


import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/utils.dart';

abstract class DataRepository extends AppSingleton implements DataRepositoryMethods {
  @override
  Future<void> onLogin() async {}
  @override
  Future<void> onLogout() async {}
  @override
  Future<void> onResumeAppUsage() async {}
  @override
  Future<void> onInitialSetupComplete() async {}
}

abstract class DataRepositoryWithLifecycle implements DataRepositoryMethods {
  /// Initialize the repository.
  Future<void> init() async {}

  /// Dispose the repository.
  Future<void> dispose() async {}

  @override
  Future<void> onLogin() async {}
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


class ConnectedActionScheduler {
  final api = ApiManager.getInstance();

  bool _onLoginScheduled = false;
  int _onLoginScheduledCount = 0;

  /// The onResumeAppUsageSync might be also still scheduled
  /// if there was connection token error.
  void onLoginSync(Future<void> Function() action) {
    _onLoginScheduledCount++;
    final count = _onLoginScheduledCount;
    _onLoginScheduled = true;
    api.state
      .firstWhere((element) => element == ApiManagerState.connected)
      .then((value) async {
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
    api.state
      .firstWhere((element) => element == ApiManagerState.connected)
      .then((value) async {
        if (_onLoginScheduled) {
          return;
        }
        await action();
      })
      .ignore();
  }
}
