import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class DemoAccount extends SingleRowTable {
  TextColumn get demoAccountUsername => text().nullable()();
  TextColumn get demoAccountPassword => text().nullable()();
  TextColumn get demoAccountToken => text().nullable()();
}

class ImageEncryptionKey extends SingleRowTable {
  BlobColumn get imageEncryptionKey => blob().nullable()();
}

class NotificationPermissionAsked extends SingleRowTable {
  /// If true don't show notification permission asking dialog when
  /// app main view (bottom navigation is visible) is opened.
  BoolColumn get notificationPermissionAsked => boolean().withDefault(const Constant(false))();
}
