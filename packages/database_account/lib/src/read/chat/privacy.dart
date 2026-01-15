import 'package:database_account/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'privacy.g.dart';

@DriftAccessor(tables: [schema.ChatPrivacySettings])
class DaoReadPrivacy extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoReadPrivacyMixin {
  DaoReadPrivacy(super.db);

  Stream<api.ChatPrivacySettings?> watchChatPrivacySettings() {
    return (select(
      chatPrivacySettings,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      if (r == null) {
        return null;
      }
      return api.ChatPrivacySettings(
        messageStateDelivered: r.messageStateDelivered,
        messageStateSent: r.messageStateSent,
        typingIndicator: r.typingIndicator,
      );
    });
  }

  Future<api.ChatPrivacySettings?> getChatPrivacySettings() async {
    final r = await (select(
      chatPrivacySettings,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).getSingleOrNull();
    if (r == null) {
      return null;
    }
    return api.ChatPrivacySettings(
      messageStateDelivered: r.messageStateDelivered,
      messageStateSent: r.messageStateSent,
      typingIndicator: r.typingIndicator,
    );
  }
}
