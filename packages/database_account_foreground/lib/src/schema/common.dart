import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';


class IteratorSessionId extends SingleRowTable {
  IntColumn get profileIteratorSessionId => integer()
    .map(const NullAwareTypeConverter.wrap(ProfileIteratorSessionIdConverter())).nullable()();
  IntColumn get automatiProfileSearchIteratorSessionId => integer()
    .map(const NullAwareTypeConverter.wrap(AutomaticProfileSearchIteratorSessionIdConverter())).nullable()();
  IntColumn get receivedLikesIteratorSessionId => integer()
    .map(const NullAwareTypeConverter.wrap(ReceivedLikesIteratorSessionIdConverter())).nullable()();
  IntColumn get matchesIteratorSessionId => integer()
    .map(const NullAwareTypeConverter.wrap(MatchesIteratorSessionIdConverter())).nullable()();
}

class SyncVersion extends SingleRowTable {
  IntColumn get syncVersionAccount => integer().nullable()();
  IntColumn get syncVersionProfile => integer().nullable()();
  IntColumn get syncVersionMediaContent => integer().nullable()();
  IntColumn get syncVersionClientConfig => integer().nullable()();
}

class ServerMaintenance extends SingleRowTable {
  IntColumn get serverMaintenanceUnixTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get serverMaintenanceUnixTimeViewed => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
}

class CustomReportsConfig extends SingleRowTable {
  TextColumn get customReportsFileHash => text().map(const NullAwareTypeConverter.wrap(CustomReportsFileHashConverter())).nullable()();
  TextColumn get customReportsConfig => text().map(NullAwareTypeConverter.wrap(const CustomReportsConfigConverter())).nullable()();
}

class ClientFeaturesConfig extends SingleRowTable {
  TextColumn get clientFeaturesFileHash => text().map(const NullAwareTypeConverter.wrap(ClientFeaturesFileHashConverter())).nullable()();
  TextColumn get clientFeaturesConfig => text().map(NullAwareTypeConverter.wrap(const ClientFeaturesConfigConverter())).nullable()();
}

class ProfileAttributesConfig extends SingleRowTable {
  TextColumn get jsonAvailableProfileAttributesOrderMode => text().map(NullAwareTypeConverter.wrap(const AttributeOrderModeConverter())).nullable()();
}

class ProfileAttributesConfigAttributes extends Table {
  /// Attribute ID
  IntColumn get id => integer()();
  TextColumn get jsonAttribute => text().map(const AttributeConverter())();
  TextColumn get attributeHash => text().map(const ProfileAttributeHashConverter())();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
