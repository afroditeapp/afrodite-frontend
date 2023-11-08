


import 'package:pihka_frontend/utils.dart';

abstract class DataRepository extends AppSingleton {
  /// Called when the user logs in. Note that this is not called
  /// every time the app is opened, but only when the user logs in.
  ///
  /// Also note that server API is not available.
  Future<void> onLogin() async {}

  /// Called when the user logs out. Note that this is not called
  /// every time the app is closed, but only when the user logs out.
  ///
  /// Also note that server API is not available.
  Future<void> onLogout() async {}

  /// Called when the user opens app and there has been previous
  /// login.
  ///
  /// Also note that server API is not available.
  Future<void> onResumeAppUsage() async {}
}
