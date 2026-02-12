import 'package:app/data/chat/message_database_iterator.dart';
import 'package:app/localizations.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';
import 'package:database/database.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as chat;

/// Adapter to convert app's IteratorMessage to flutter_chat_core messages
class MessageAdapter {
  static chat.Message toFlutterChatMessage(
    IteratorMessage message,
    String currentUserId, {
    required bool messageStateSeenEnabled,
  }) {
    return switch (message) {
      IteratorMessageEntry(:final entry) => messageEntryToFlutterChatMessage(
        entry,
        currentUserId,
        messageStateSeenEnabled: messageStateSeenEnabled,
      ),
      MessageDateChange(:final date) => chat.Message.system(
        id: 'date_${date.millisecondsSinceEpoch}',
        authorId: currentUserId,
        text: "",
        createdAt: date,
        metadata: {'type': 'date_change', 'generated': true},
      ),
    };
  }

  static chat.Message messageEntryToFlutterChatMessage(
    MessageEntry entry,
    String currentUserId, {
    required bool messageStateSeenEnabled,
  }) {
    final isCurrentUser = entry.messageState.toSentState() != null;
    final authorId = isCurrentUser ? currentUserId : entry.remoteAccountId.aid;
    final createdAt = entry.userVisibleTime().dateTime;

    final infoMessageState = entry.messageState.toInfoState();
    if (infoMessageState != null) {
      return chat.Message.system(
        id: entry.localId.id.toString(),
        authorId: authorId,
        text: "",
        createdAt: createdAt,
        metadata: {'infoMessageType': infoMessageState.name},
      );
    }

    final sentMessageState = entry.messageState.toSentState();
    final receivedMessageState = entry.messageState.toReceivedState();

    // Determine message status based on state
    chat.MessageStatus? status;
    DateTime? sentAt;
    DateTime? deliveredAt;
    DateTime? seenAt;
    DateTime? failedAt;

    final Map<String, dynamic> metadata = {};

    if (sentMessageState != null) {
      switch (sentMessageState) {
        case SentMessageState.pending:
          status = chat.MessageStatus.sending;
        case SentMessageState.sent:
          sentAt = createdAt;
          status = chat.MessageStatus.sent;
        case SentMessageState.delivered:
          deliveredAt = entry.deliveredUnixTime?.dateTime ?? createdAt;
          status = chat.MessageStatus.delivered;
        case SentMessageState.seen:
          if (messageStateSeenEnabled) {
            seenAt = entry.seenUnixTime?.dateTime ?? createdAt;
            status = chat.MessageStatus.seen;
          } else {
            deliveredAt = entry.deliveredUnixTime?.dateTime ?? createdAt;
            status = chat.MessageStatus.delivered;
          }
        case SentMessageState.sendingError:
          failedAt = createdAt;
          status = chat.MessageStatus.error;
        case SentMessageState.deliveryFailed:
          failedAt = entry.deliveredUnixTime?.dateTime ?? createdAt;
          status = chat.MessageStatus.error;
        case SentMessageState.deliveryFailedAndResent:
          failedAt = entry.deliveredUnixTime?.dateTime ?? createdAt;
          status = chat.MessageStatus.error;
      }
    } else if (receivedMessageState != null) {
      seenAt = createdAt;
      status = chat.MessageStatus.seen;
    }

    if (sentMessageState != null) {
      metadata['sentMessageState'] = sentMessageState;
    }

    final resentMessage = entry.message;
    final Message? message;

    if (resentMessage is ResentMessage) {
      metadata['footer'] = R.strings.conversation_screen_message_resent_info(
        timeString(resentMessage.sentUnixTime.toUtcDateTime()),
        resentMessage.messageNumber.mn.toString(),
      );
      message = resentMessage.message.removeResentMessages();
    } else {
      message = resentMessage;
    }

    if (message is TextMessage) {
      return chat.Message.text(
        id: entry.localId.id.toString(),
        authorId: authorId,
        text: message.text,
        createdAt: createdAt,
        sentAt: sentAt,
        deliveredAt: deliveredAt,
        seenAt: seenAt,
        failedAt: failedAt,
        status: status,
        metadata: {'type': 'text_message', ...metadata},
      );
    } else if (message is MessageWithReference) {
      return chat.Message.text(
        id: entry.localId.id.toString(),
        authorId: authorId,
        text: message.text,
        createdAt: createdAt,
        sentAt: sentAt,
        deliveredAt: deliveredAt,
        seenAt: seenAt,
        failedAt: failedAt,
        status: status,
        replyToMessageId: message.messageId,
        metadata: {'type': 'message_with_reference', ...metadata},
      );
    } else if (message is VideoCallInvitation) {
      return chat.Message.custom(
        id: entry.localId.id.toString(),
        authorId: authorId,
        createdAt: createdAt,
        sentAt: sentAt,
        deliveredAt: deliveredAt,
        seenAt: seenAt,
        failedAt: failedAt,
        status: status,
        metadata: {'type': 'video_call_invitation', ...metadata},
      );
    } else if (message is UnsupportedMessage) {
      return chat.Message.custom(
        id: entry.localId.id.toString(),
        authorId: authorId,
        createdAt: createdAt,
        sentAt: sentAt,
        deliveredAt: deliveredAt,
        seenAt: seenAt,
        failedAt: failedAt ?? createdAt,
        status: chat.MessageStatus.error,
        metadata: {'type': 'error_message', 'errorType': 'unsupported', ...metadata},
      );
    } else {
      final String errorType;
      if (receivedMessageState == ReceivedMessageState.decryptingFailed) {
        errorType = 'decrypting_failed';
      } else if (receivedMessageState == ReceivedMessageState.publicKeyDownloadFailed) {
        errorType = 'key_download_failed';
      } else {
        errorType = 'generic';
      }

      return chat.Message.custom(
        id: entry.localId.id.toString(),
        authorId: authorId,
        createdAt: createdAt,
        sentAt: sentAt,
        deliveredAt: deliveredAt,
        seenAt: seenAt,
        failedAt: failedAt ?? createdAt,
        status: chat.MessageStatus.error,
        metadata: {'type': 'error_message', 'errorType': errorType, ...metadata},
      );
    }
  }

  static List<chat.Message> toFlutterChatMessages(
    List<IteratorMessage> messages,
    String currentUserId, {
    required bool messageStateSeenEnabled,
  }) {
    return messages
        .map(
          (entry) => toFlutterChatMessage(
            entry,
            currentUserId,
            messageStateSeenEnabled: messageStateSeenEnabled,
          ),
        )
        .toList();
  }
}
