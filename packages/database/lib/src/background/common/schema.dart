
import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class AccountId extends SingleRowTable {
  TextColumn get uuidAccountId => text().map(const NullAwareTypeConverter.wrap(AccountIdConverter())).nullable()();
}

class ServerUrl extends SingleRowTable {
  TextColumn get serverUrlAccount => text().nullable()();
  TextColumn get serverUrlMedia => text().nullable()();
  TextColumn get serverUrlProfile => text().nullable()();
  TextColumn get serverUrlChat => text().nullable()();
}

class PushNotification extends SingleRowTable {
  TextColumn get fcmDeviceToken => text().map(const NullAwareTypeConverter.wrap(FcmDeviceTokenConverter())).nullable()();
  TextColumn get pendingNotificationToken => text().map(const NullAwareTypeConverter.wrap(PendingNotificationTokenConverter())).nullable()();
}

class CurrentLocale extends SingleRowTable {
  TextColumn get currentLocale => text().nullable()();
}
