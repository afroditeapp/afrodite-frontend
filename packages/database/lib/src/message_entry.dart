


import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class MessageEntry {
  /// Local database ID of the message.
  final LocalMessageId localId;

  final AccountId localAccountId;
  final AccountId remoteAccountId;
  /// For sent messages this is normal text. For received messages this can
  /// be normal text or when in error state base64 encoded message bytes.
  final String messageText;
  /// Local/client time when message entry is inserted to database.
  final UtcDateTime localUnixTime;
  /// Null if message was received.
  final SentMessageState? sentMessageState;
  /// Null if message was sent.
  final ReceivedMessageState? receivedMessageState;
  /// Message number in a conversation. Server sets this value.
  final MessageNumber? messageNumber;
  /// Time since Unix epoch. Server sets this falue.
  final UtcDateTime? unixTime;

  MessageEntry(
    {
      required this.localId,
      required this.localAccountId,
      required this.remoteAccountId,
      required this.messageText,
      required this.localUnixTime,
      this.sentMessageState,
      this.receivedMessageState,
      this.messageNumber,
      this.unixTime,
    }
  );

  @override
  String toString() {
    return "MessageEntry(localId: $localId, localAccountId: $localAccountId, remoteAccountId: $remoteAccountId, messageText: $messageText, sentMessageState: $sentMessageState, receivedMessageState: $receivedMessageState, messageNumber: $messageNumber, unixTime: $unixTime)";
  }
}

enum SentMessageState {
  /// Waiting to be sent to server.
  pending(0),
  /// Sent to server, but not yet received by the other user.
  sent(1),
  /// Sending failed.
  sendingError(2);

  bool isError() {
    return this == SentMessageState.sendingError;
  }

  const SentMessageState(this.number);
  final int number;
}

enum ReceivedMessageState {
  /// Received successfully
  received(0),
  /// Received, but decrypting failed
  decryptingFailed(1),
  /// Received, but message type is unknown.
  unknownMessageType(2);

  bool isError() {
    return this == ReceivedMessageState.decryptingFailed ||
      this == ReceivedMessageState.unknownMessageType;
  }

  const ReceivedMessageState(this.number);
  final int number;
}

class NewMessageEntry {
  final AccountId localAccountId;
  final AccountId remoteAccountId;
  final String messageText;
  /// Local/client time when message entry is inserted to database.
  final UtcDateTime localUnixTime;
  /// Null if message was received.
  final SentMessageState? sentMessageState;
  /// Null if message was sent.
  final ReceivedMessageState? receivedMessageState;
  /// Message number in a conversation. Server sets this value.
  final MessageNumber? messageNumber;
  /// Time since Unix epoch. Server sets this falue.
  final UtcDateTime? unixTime;

  NewMessageEntry(
    {
      required this.localAccountId,
      required this.remoteAccountId,
      required this.messageText,
      required this.localUnixTime,
      this.sentMessageState,
      this.receivedMessageState,
      this.messageNumber,
      this.unixTime,
    }
  );

  @override
  String toString() {
    return "NewMessageEntry(localAccountId: $localAccountId, remoteAccountId: $remoteAccountId, messageText: $messageText, sentMessageState: $sentMessageState, receivedMessageState: $receivedMessageState, messageNumber: $messageNumber, unixTime: $unixTime)";
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

class UnreadMessagesCount {
  final int count;
  const UnreadMessagesCount(this.count);

  @override
  bool operator ==(Object other) {
    return (other is UnreadMessagesCount && count == other.count);
  }

  @override
  int get hashCode => Object.hash(runtimeType, count);
}
