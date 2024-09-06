
abstract class AppSingleton {
  /// Initialize the singleton. Runs when app splash screen is visible.
  Future<void> init();
}

abstract class AppSingletonNoInit {}
