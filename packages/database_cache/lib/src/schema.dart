import 'package:drift/drift.dart';

/// Cache entry table for image cache metadata.
/// Stored in a dedicated cache DB in system cache directory.
class CacheEntry extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Unique entry key within the cache
  TextColumn get entryKey => text().unique()();

  /// Whether the file was saved successfully to disk
  BoolColumn get savedSuccessfully => boolean().withDefault(const Constant(false))();

  /// Server ETag for conditional requests
  TextColumn get etag => text().nullable()();

  /// When this entry becomes stale and should be revalidated
  DateTimeColumn get staleAt => dateTime()();

  /// When this entry should be deleted unconditionally
  DateTimeColumn get expireAt => dateTime()();
}
