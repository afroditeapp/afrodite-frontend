
import 'package:database_account_foreground/src/database.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';

import '../../schema.dart' as schema;

part 'conversation_list.g.dart';

@DriftAccessor(
  tables: [
    schema.ConversationList,
  ]
)
class DaoWriteConversationList extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoWriteConversationListMixin {
  DaoWriteConversationList(super.db);

 Future<void> setConversationListVisibility(
    api.AccountId accountId,
    bool value,
  ) async {
    await into(conversationList).insert(
      ConversationListCompanion.insert(
        uuidAccountId: accountId,
        isInConversationList: _toGroupValue(value),
      ),
      onConflict: DoUpdate((old) => ConversationListCompanion(
        isInConversationList: _toGroupValue(value),
      ),
        target: [conversationList.uuidAccountId]
      ),
    );
  }

  Future<void> setSentBlockStatus(
    api.AccountId accountId,
    bool value,
  ) async {
    await into(conversationList).insert(
      ConversationListCompanion.insert(
        uuidAccountId: accountId,
        isInSentBlocks: _toGroupValue(value),
      ),
      onConflict: DoUpdate((old) => ConversationListCompanion(
        isInSentBlocks: _toGroupValue(value),
      ),
        target: [conversationList.uuidAccountId]
      ),
    );
  }

  Future<void> setSentBlockStatusList(api.SentBlocksPage sentBlocks) async {
    await transaction(() async {
      // Clear
      await update(conversationList)
        .write(const ConversationListCompanion(isInSentBlocks: Value(null)));

      for (final a in sentBlocks.profiles) {
        await setSentBlockStatus(a, true);
      }
    });
  }

  Value<UtcDateTime?> _toGroupValue(bool value) {
    if (value) {
      return Value(UtcDateTime.now());
    } else {
      return const Value(null);
    }
  }

  Future<void> setCurrentTimeToConversationLastChanged(api.AccountId accountId) async {
    final currentTime = UtcDateTime.now();
    await into(conversationList).insert(
      ConversationListCompanion.insert(
        uuidAccountId: accountId,
        conversationLastChangedTime: Value(currentTime),
      ),
      onConflict: DoUpdate((old) => ConversationListCompanion(
        conversationLastChangedTime: Value(currentTime),
      ),
        target: [conversationList.uuidAccountId]
      ),
    );
  }
}
