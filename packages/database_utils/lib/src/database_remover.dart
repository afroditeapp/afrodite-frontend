abstract class DatabaseRemover {
  Future<void> recreateDatabasesDir();

  /// Deletes all databases.
  /// This is useful for development/preview versions when breaking changes occur.
  Future<void> deleteAllDatabases();
}
