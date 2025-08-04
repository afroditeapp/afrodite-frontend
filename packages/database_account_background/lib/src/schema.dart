
import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class AccountId extends SingleRowTable {
  TextColumn get accountId => text().map(const AccountIdConverter())();
}

class AdminNotification extends SingleRowTable {
  TextColumn get jsonViewedNotification => text().map(NullAwareTypeConverter.wrap(const AdminNotificationConverter())).nullable()();
}

class AppNotificationSettings extends SingleRowTable {
  BoolColumn get messages => boolean().nullable()();
  BoolColumn get likes => boolean().nullable()();
  BoolColumn get mediaContentModerationCompleted => boolean().nullable()();
  BoolColumn get profileTextModerationCompleted => boolean().nullable()();
  BoolColumn get news => boolean().nullable()();

  BoolColumn get automaticProfileSearch => boolean().nullable()();
  BoolColumn get automaticProfileSearchDistanceFilters => boolean().nullable()();
  BoolColumn get automaticProfileSearchAttributeFilters => boolean().nullable()();
  BoolColumn get automaticProfileSearchNewProfiles => boolean().nullable()();
  IntColumn get automaticProfileSearchWeekdays => integer().nullable()();
}

/// Notifications with NotificationStatus (ID and viewed ID) available.
class NotificationStatus extends SingleRowTable {
  TextColumn get jsonAutomaticProfileSearchFoundProfiles => text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonMediaContentAccepted => text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonMediaContentRejected => text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonMediaContentDeleted => text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonProfileNameAccepted => text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonProfileNameRejected => text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonProfileTextAccepted => text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonProfileTextRejected => text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
}

class UnreadMessagesCount extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();
  IntColumn get unreadMessagesCount => integer().map(UnreadMessagesCountConverter()).withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

class NewMessageNotification extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();
  IntColumn get conversationId => integer().map(const NullAwareTypeConverter.wrap(ConversationIdConverter())).nullable()();
  BoolColumn get notificationShown => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

class NewReceivedLikesCount extends SingleRowTable {
  IntColumn get syncVersionReceivedLikes => integer().nullable()();
  IntColumn get newReceivedLikesCount => integer().map(const NullAwareTypeConverter.wrap(NewReceivedLikesCountConverter())).nullable()();

  /// Count which will be reset once user views received likes screen
  IntColumn get newReceivedLikesCountNotViewed => integer().map(const NullAwareTypeConverter.wrap(NewReceivedLikesCountConverter())).nullable()();
}

class News extends SingleRowTable {
  IntColumn get newsCount => integer().map(const NullAwareTypeConverter.wrap(UnreadNewsCountConverter())).nullable()();
  IntColumn get syncVersionNews => integer().nullable()();
}

class Profile extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();
  TextColumn get profileName => text().nullable()();
  BoolColumn get profileNameAccepted => boolean().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}
