abstract class DatabaseRemover {
  Future<void> recreateDatabasesDir({required bool backgroundDb});

  /// Deletes all databases (both foreground and background).
  /// This is useful for development/preview versions when breaking changes occur.
  Future<void> deleteAllDatabases();
}
