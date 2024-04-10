


import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class MessageEntry {
  /// Local database ID of the message.
  /// This really is not null. Null is to avoid setting ID when inserting.
  final int? id;
  int get localId => id!;

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

  MessageEntry(
    {
      required this.localAccountId,
      required this.remoteAccountId,
      required this.messageText,
      this.sentMessageState,
      this.receivedMessageState,
      this.messageNumber,
      this.unixTime,
      this.id,
    }
  );

  @override
  String toString() {
    return "MessageEntry(id: $id, localAccountId: $localAccountId, remoteAccountId: $remoteAccountId, messageText: $messageText, sentMessageState: $sentMessageState, receivedMessageState: $receivedMessageState, messageNumber: $messageNumber, unixTime: $unixTime)";
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
  /// Message is deleted from server.
  deletedFromServer(1);

  const ReceivedMessageState(this.number);
  final int number;
}
