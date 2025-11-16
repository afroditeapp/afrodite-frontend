import 'package:app/data/chat/message_database_iterator.dart';
import 'package:database/database.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as chat;

/// Adapter to convert app's IteratorMessage to flutter_chat_core messages
class MessageAdapter {
  static chat.Message toFlutterChatMessage(IteratorMessage message, String currentUserId) {
    return switch (message) {
      IteratorMessageEntry(:final entry) => messageEntryToFlutterChatMessage(entry, currentUserId),
      MessageDateChange(:final date) => chat.Message.system(
        id: 'date_${date.millisecondsSinceEpoch}',
        authorId: currentUserId,
        text: "",
        createdAt: date,
        metadata: {'type': 'date_change'},
      ),
    };
  }

  static chat.Message messageEntryToFlutterChatMessage(MessageEntry entry, String currentUserId) {
    final isCurrentUser = entry.messageState.toSentState() != null;
    final authorId = isCurrentUser ? currentUserId : entry.remoteAccountId.aid;
    final createdAt = entry.unixTime?.dateTime ?? entry.localUnixTime.dateTime;

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

    final message = entry.message;
    final sentMessageState = entry.messageState.toSentState();
    final receivedMessageState = entry.messageState.toReceivedState();

    // Determine message status based on state
    chat.MessageStatus? status;
    DateTime? sentAt;
    DateTime? deliveredAt;
    DateTime? seenAt;
    DateTime? failedAt;

    if (sentMessageState != null) {
      switch (sentMessageState) {
        case SentMessageState.pending:
          status = chat.MessageStatus.sending;
        case SentMessageState.sent:
          sentAt = createdAt;
          status = chat.MessageStatus.sent;
        case SentMessageState.sendingError:
          failedAt = createdAt;
          status = chat.MessageStatus.error;
      }
    } else if (receivedMessageState != null) {
      seenAt = createdAt;
      status = chat.MessageStatus.seen;
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
        metadata: const {'type': 'video_call_invitation'},
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
        metadata: const {'type': 'error_message', 'errorType': 'unsupported'},
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
        metadata: {'type': 'error_message', 'errorType': errorType},
      );
    }
  }

  static List<chat.Message> toFlutterChatMessages(
    List<IteratorMessage> messages,
    String currentUserId,
  ) {
    return messages.map((entry) => toFlutterChatMessage(entry, currentUserId)).toList();
  }
}
