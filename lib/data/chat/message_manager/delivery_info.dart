import 'package:database/database.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/data/chat/message_manager/public_key.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/result.dart';
import 'package:utils/utils.dart';

class DeliveryInfoUtils {
  final AccountDatabaseManager db;
  final ApiManager api;
  final AccountId currentUser;
  final PublicKeyUtils publicKeyUtils;

  DeliveryInfoUtils(this.db, this.api, this.currentUser)
    : publicKeyUtils = PublicKeyUtils(db, api, currentUser);

  Future<void> receiveMessageDeliveryInfo() async {
    final deliveryInfoList = await api.chat((api) => api.getMessageDeliveryInfo()).ok();
    if (deliveryInfoList == null) {
      return;
    }

    final List<int> processedIds = [];
    final Set<AccountId> checkEncryptionKeyChanges = {};

    for (final deliveryInfo in deliveryInfoList.info) {
      final message = await db
          .accountData(
            (db) =>
                db.message.getMessageUsingMessageId(deliveryInfo.receiver, deliveryInfo.messageId),
          )
          .ok();

      if (message == null) {
        // Message not found in DB
        processedIds.add(deliveryInfo.id);
        continue;
      }

      final currentState = message.messageState.toSentState();
      if (currentState == null) {
        // Not a sent message
        processedIds.add(deliveryInfo.id);
        continue;
      }

      SentMessageState? newState;
      UtcDateTime? deliveredTime;
      UtcDateTime? seenTime;

      if (deliveryInfo.deliveryType == DeliveryInfoType.delivered) {
        if (currentState != SentMessageState.seen) {
          newState = SentMessageState.delivered;
          deliveredTime = deliveryInfo.unixTime.toUtcDateTime();
        }
      } else if (deliveryInfo.deliveryType == DeliveryInfoType.deliveryFailed) {
        checkEncryptionKeyChanges.add(deliveryInfo.receiver);
        if (currentState != SentMessageState.seen && currentState != SentMessageState.delivered) {
          newState = SentMessageState.deliveryFailed;
        }
      }

      if (newState != null) {
        final result = await db.accountAction(
          (db) => db.message.updateSentMessageState(
            message.localId,
            sentState: newState,
            deliveredUnixTime: deliveredTime,
            seenUnixTime: seenTime,
          ),
        );

        if (result.isOk()) {
          // Only mark as processed if successfully saved to DB
          processedIds.add(deliveryInfo.id);

          await _setProfileOnlineIfDeliveryInfoIsRecent(
            deliveryInfo.receiver,
            deliveryInfo.unixTime.toUtcDateTime(),
          );
        }
      } else {
        // If no state change needed, still mark as processed
        processedIds.add(deliveryInfo.id);
      }
    }

    if (processedIds.isNotEmpty) {
      await api.chatAction(
        (api) => api.postDeleteMessageDeliveryInfo(MessageDeliveryInfoIdList(ids: processedIds)),
      );
    }

    if (checkEncryptionKeyChanges.isNotEmpty) {
      for (final accountId in checkEncryptionKeyChanges) {
        await publicKeyUtils.getLatestPublicKeyForForeignAccount(accountId);
      }
    }
  }

  Future<void> receiveLatestSeenMessageInfo() async {
    final seenInfoList = await api.chat((api) => api.getPendingLatestSeenMessages()).ok();
    if (seenInfoList == null) {
      return;
    }

    final List<LatestSeenMessageInfo> processedInfo = [];

    for (final info in seenInfoList.info) {
      final result = await db.accountAction(
        (db) => db.message.updateSentMessagesToSeen(info.viewer, info.mn, info.ut.toUtcDateTime()),
      );

      if (result.isOk()) {
        processedInfo.add(info);
      }
    }

    if (processedInfo.isNotEmpty) {
      await api.chatAction(
        (api) =>
            api.postDeletePendingLatestSeenMessages(LatestSeenMessageInfoList(info: processedInfo)),
      );
    }
  }

  Future<void> _setProfileOnlineIfDeliveryInfoIsRecent(
    AccountId accountId,
    UtcDateTime eventTime,
  ) async {
    if (_isTimestampRecent(eventTime)) {
      await db.accountAction((db) => db.profile.updateProfileLastSeenTimeIfNeeded(accountId, -1));
    }
  }

  bool _isTimestampRecent(UtcDateTime timestamp) {
    final now = UtcDateTime.now();
    final differenceInSeconds =
        (now.toUnixEpochMilliseconds() - timestamp.toUnixEpochMilliseconds()).abs() / 1000;
    return differenceInSeconds <= 30;
  }
}
