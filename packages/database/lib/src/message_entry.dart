


import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class MessageEntry {
  /// Local database ID of the message.
  final LocalMessageId localId;

  final AccountId localAccountId;
  final AccountId remoteAccountId;
  final String messageText;
  /// Null if message was received.
  final SentMessageState? sentMessageState;
  /// Null if message was sent.
  final ReceivedMessageState? receivedMessageState;
  /// Message number in a conversation. Server sets this value.
  final MessageNumber? messageNumber;
  /// Time since Unix epoch. Server sets this falue.
  final UtcDateTime? unixTime;

  /// Sender message ID for sent messages. Used for detecting message sending
  /// failures.
  final SenderMessageId? senderMessageId;

  MessageEntry(
    {
      required this.localId,
      required this.localAccountId,
      required this.remoteAccountId,
      required this.messageText,
      this.sentMessageState,
      this.receivedMessageState,
      this.messageNumber,
      this.unixTime,
      this.senderMessageId,
    }
  );

  @override
  String toString() {
    return "MessageEntry(localId: $localId, localAccountId: $localAccountId, remoteAccountId: $remoteAccountId, messageText: $messageText, sentMessageState: $sentMessageState, receivedMessageState: $receivedMessageState, messageNumber: $messageNumber, unixTime: $unixTime, senderMessageId: $senderMessageId)";
  }
}

enum SentMessageState {
  /// Waiting to be sent to server.
  pending(0),
  /// Sent to server, but not yet received by the other user.
  sent(1),
  /// Received by the other user.
  received(2),
  /// Read by the other user.
  read(3),
  /// Sending failed.
  sendingError(4);

  const SentMessageState(this.number);
  final int number;
}

enum ReceivedMessageState {
  /// Waiting to be deleted from server.
  waitingDeletionFromServer(0),
  /// Waiting to be deleted from server and decrypting failed.
  waitingDeletionFromServerAndDecryptingFailed(1),
  /// Message is deleted from server.
  deletedFromServer(2),
  /// Message is deleted from server and decrypting failed.
  deletedFromServerAndDecryptingFailed(3);

  const ReceivedMessageState(this.number);
  final int number;

  bool decryptingFailed() {
    return this == ReceivedMessageState.deletedFromServerAndDecryptingFailed ||
      this == ReceivedMessageState.waitingDeletionFromServerAndDecryptingFailed;
  }
}

class NewMessageEntry {
  final AccountId localAccountId;
  final AccountId remoteAccountId;
  final String messageText;
  /// Null if message was received.
  final SentMessageState? sentMessageState;
  /// Null if message was sent.
  final ReceivedMessageState? receivedMessageState;
  /// Message number in a conversation. Server sets this value.
  final MessageNumber? messageNumber;
  /// Time since Unix epoch. Server sets this falue.
  final UtcDateTime? unixTime;

  /// Sender message ID for sent messages. Used for detecting message sending
  /// failures.
  final SenderMessageId? senderMessageId;

  NewMessageEntry(
    {
      required this.localAccountId,
      required this.remoteAccountId,
      required this.messageText,
      this.sentMessageState,
      this.receivedMessageState,
      this.messageNumber,
      this.unixTime,
      this.senderMessageId,
    }
  );

  @override
  String toString() {
    return "NewMessageEntry(localAccountId: $localAccountId, remoteAccountId: $remoteAccountId, messageText: $messageText, sentMessageState: $sentMessageState, receivedMessageState: $receivedMessageState, messageNumber: $messageNumber, unixTime: $unixTime, senderMessageId: $senderMessageId)";
  }
}

class LocalMessageId {
  final int id;
  const LocalMessageId(this.id);

  @override
  bool operator ==(Object other) {
    return (other is LocalMessageId && id == other.id);
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);
}
