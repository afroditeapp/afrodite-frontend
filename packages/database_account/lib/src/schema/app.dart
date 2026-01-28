import 'package:database_utils/database_utils.dart';
import 'package:database_converter/database_converter.dart';
import 'package:drift/drift.dart';

class ProfileFilterFavorites extends SingleRowTable {
  /// If true show only favorite profiles
  BoolColumn get profileFilterFavorites => boolean().withDefault(const Constant(false))();
}

class ShowAdvancedProfileFilters extends SingleRowTable {
  BoolColumn get advancedFilters => boolean().withDefault(const Constant(false))();
}

class InitialSync extends SingleRowTable {
  BoolColumn get initialSyncDoneLoginRepository => boolean().withDefault(const Constant(false))();
  BoolColumn get initialSyncDoneAccountRepository => boolean().withDefault(const Constant(false))();
  BoolColumn get initialSyncDoneMediaRepository => boolean().withDefault(const Constant(false))();
  BoolColumn get initialSyncDoneProfileRepository => boolean().withDefault(const Constant(false))();
  BoolColumn get initialSyncDoneChatRepository => boolean().withDefault(const Constant(false))();
}

class InitialSetupSkipped extends SingleRowTable {
  BoolColumn get initialSetupSkipped => boolean().withDefault(const Constant(false))();
}

class GridSettings extends SingleRowTable {
  /// - 0 = Small
  /// - 1 = Medium
  /// - 2 = Large
  IntColumn get gridItemSizeMode => integer().nullable()();

  /// - 0 = Small
  /// - 1 = Medium
  /// - 2 = Large
  /// - 3 = Disabled
  IntColumn get gridPaddingMode => integer().nullable()();
}

class ChatBackupReminder extends SingleRowTable {
  /// Backup reminder interval in days. 0 = disabled, null = use default value
  IntColumn get reminderIntervalDays => integer().nullable()();

  /// Last time a backup was created
  IntColumn get lastBackupTime =>
      integer().map(NullAwareTypeConverter.wrap(const UtcDateTimeConverter())).nullable()();

  /// Last time the reminder dialog was opened
  IntColumn get lastDialogOpenedTime =>
      integer().map(NullAwareTypeConverter.wrap(const UtcDateTimeConverter())).nullable()();
}

class AdminNotification extends SingleRowTable {
  TextColumn get jsonViewedNotification =>
      text().map(NullAwareTypeConverter.wrap(const AdminNotificationConverter())).nullable()();
}

class AppNotificationSettings extends SingleRowTable {
  BoolColumn get messages => boolean().nullable()();
  BoolColumn get likes => boolean().nullable()();
  BoolColumn get mediaContentModerationCompleted => boolean().nullable()();
  BoolColumn get profileStringModerationCompleted => boolean().nullable()();
  BoolColumn get news => boolean().nullable()();
  BoolColumn get automaticProfileSearch => boolean().nullable()();
}

/// Notifications with NotificationStatus (ID and viewed ID) available.
class NotificationStatus extends SingleRowTable {
  TextColumn get jsonAutomaticProfileSearchFoundProfiles =>
      text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonMediaContentAccepted =>
      text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonMediaContentRejected =>
      text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonMediaContentDeleted =>
      text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonProfileNameAccepted =>
      text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonProfileNameRejected =>
      text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonProfileTextAccepted =>
      text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
  TextColumn get jsonProfileTextRejected =>
      text().map(NullAwareTypeConverter.wrap(const NotificationStatusConverter())).nullable()();
}

class News extends SingleRowTable {
  IntColumn get newsCount =>
      integer().map(const NullAwareTypeConverter.wrap(UnreadNewsCountConverter())).nullable()();
  IntColumn get syncVersionNews => integer().nullable()();
}

class PushNotification extends SingleRowTable {
  TextColumn get pushNotificationDeviceToken => text()
      .map(const NullAwareTypeConverter.wrap(PushNotificationDeviceTokenConverter()))
      .nullable()();
  TextColumn get vapidPublicKey =>
      text().map(const NullAwareTypeConverter.wrap(VapidPublicKeyConverter())).nullable()();
  IntColumn get syncVersionPushNotificationInfo => integer().nullable()();
}
