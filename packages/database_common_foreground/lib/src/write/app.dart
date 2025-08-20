import 'package:database_common_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../schema.dart' as schema;

part 'app.g.dart';

@DriftAccessor(
  tables: [
    schema.ChatInfoDialogShown,
    schema.NotificationPermissionAsked,
    schema.ImageEncryptionKey,
  ],
)
class DaoWriteApp extends DatabaseAccessor<CommonForegroundDatabase> with _$DaoWriteAppMixin {
  DaoWriteApp(super.db);

  Future<void> updateImageEncryptionKey(Uint8List key) async {
    await into(imageEncryptionKey).insertOnConflictUpdate(
      ImageEncryptionKeyCompanion.insert(id: SingleRowTable.ID, imageEncryptionKey: Value(key)),
    );
  }

  Future<void> updateNotificationPermissionAsked(bool value) async {
    await into(notificationPermissionAsked).insertOnConflictUpdate(
      NotificationPermissionAskedCompanion.insert(
        id: SingleRowTable.ID,
        notificationPermissionAsked: Value(value),
      ),
    );
  }

  Future<void> updateChatInfoDialogShown(bool value) async {
    await into(chatInfoDialogShown).insertOnConflictUpdate(
      ChatInfoDialogShownCompanion.insert(id: SingleRowTable.ID, chatInfoDialogShown: Value(value)),
    );
  }
}
