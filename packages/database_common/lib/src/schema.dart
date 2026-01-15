import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class DemoAccount extends SingleRowTable {
  TextColumn get demoAccountUsername => text().nullable()();
  TextColumn get demoAccountPassword => text().nullable()();
  TextColumn get demoAccountToken => text().nullable()();
}

class NotificationPermissionAsked extends SingleRowTable {
  /// If true don't show notification permission asking dialog when
  /// app main view (bottom navigation is visible) is opened.
  BoolColumn get notificationPermissionAsked => boolean().withDefault(const Constant(false))();
}

class AccountId extends SingleRowTable {
  TextColumn get accountId =>
      text().map(const NullAwareTypeConverter.wrap(AccountIdConverter())).nullable()();
}

class ServerUrl extends SingleRowTable {
  TextColumn get serverUrl => text().nullable()();
}

class CurrentLocale extends SingleRowTable {
  TextColumn get currentLocale => text().nullable()();
}
