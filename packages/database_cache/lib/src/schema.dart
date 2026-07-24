import 'package:drift/drift.dart';

/// Cache entry table for image cache metadata.
/// Stored in a dedicated cache DB in system cache directory.
class CacheEntry extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Unique entry key within the cache
  TextColumn get entryKey => text().unique()();

  /// Whether the file was saved successfully to disk
  BoolColumn get savedSuccessfully => boolean().withDefault(const Constant(false))();

  /// Last accessed timestamp
  DateTimeColumn get lastAccessed => dateTime()();
}
