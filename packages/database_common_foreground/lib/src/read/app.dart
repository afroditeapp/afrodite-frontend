import 'package:database_common_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../schema.dart' as schema;

part 'app.g.dart';

@DriftAccessor(
  tables: [
    schema.ImageEncryptionKey,
    schema.NotificationPermissionAsked,
    schema.ChatInfoDialogShown,
  ],
)
class DaoReadApp extends DatabaseAccessor<CommonForegroundDatabase> with _$DaoReadAppMixin {
  DaoReadApp(super.db);

  Stream<Uint8List?> watchImageEncryptionKey() =>
      _watchImageEncryptionKeyColumn((r) => r.imageEncryptionKey);

  Stream<bool?> watchNotificationPermissionAsked() =>
      _watchNotificationPermissionAskedColumn((r) => r.notificationPermissionAsked);

  Stream<bool?> watchChatInfoDialogShown() =>
      _watchChatInfoDialogShownColumn((r) => r.chatInfoDialogShown);

  Stream<T?> _watchImageEncryptionKeyColumn<T extends Object>(
    T? Function(ImageEncryptionKeyData) extractColumn,
  ) {
    return (select(
      imageEncryptionKey,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<T?> _watchNotificationPermissionAskedColumn<T extends Object>(
    T? Function(NotificationPermissionAskedData) extractColumn,
  ) {
    return (select(
      notificationPermissionAsked,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<T?> _watchChatInfoDialogShownColumn<T extends Object>(
    T? Function(ChatInfoDialogShownData) extractColumn,
  ) {
    return (select(
      chatInfoDialogShown,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }
}
