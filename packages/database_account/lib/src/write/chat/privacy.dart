import 'package:database_account/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'privacy.g.dart';

@DriftAccessor(tables: [schema.ChatPrivacySettings])
class DaoWritePrivacy extends DatabaseAccessor<AccountDatabase> with _$DaoWritePrivacyMixin {
  DaoWritePrivacy(super.db);

  Future<void> updateChatPrivacySettings(api.ChatPrivacySettings settings) async {
    await into(chatPrivacySettings).insertOnConflictUpdate(
      ChatPrivacySettingsCompanion.insert(
        id: SingleRowTable.ID,
        messageStateDelivered: Value(settings.messageStateDelivered),
        messageStateSent: Value(settings.messageStateSent),
        typingIndicator: Value(settings.typingIndicator),
      ),
    );
  }
}
