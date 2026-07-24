import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
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

/// Cache entry for content quality information (h/m/l).
/// Stored in cache DB because this data is transient and can be re-fetched.
class ContentQuality extends Table {
  TextColumn get accountId => text()();
  TextColumn get contentId => text()();

  /// Quality returned by server: "h", "m", or "l"
  TextColumn get quality => text()();

  /// Timestamp when the request was made
  IntColumn get lastRequestTime => integer().map(const UtcDateTimeConverter())();

  @override
  Set<Column<Object>> get primaryKey => {accountId, contentId};
}

/// Tracks last cleanup run for stale content quality entries.
class ContentQualityCleanupState extends SingleRowTable {
  IntColumn get lastCleanupTime =>
      integer().map(NullAwareTypeConverter.wrap(const UtcDateTimeConverter())).nullable()();
}
