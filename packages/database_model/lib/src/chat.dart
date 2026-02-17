import 'dart:typed_data';

import 'chat/message.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class MessageEntry {
  /// Local database ID of the message.
  final LocalMessageId localId;

  final AccountId remoteAccountId;

  /// For sent messages this is Message. For received messages this can
  /// be Message or in error state null.
  final Message? message;

  /// Local/client time when message entry is inserted to database.
  final UtcDateTime localUnixTime;
  final MessageState messageState;

  /// Conversation specific number for the message. Server sets this value.
  final MessageNumber? messageNumber;

  /// Message sender generated UUID for the message.
  final MessageId? messageId;

  /// Time when the message was sent. Server sets this falue.
  final UtcDateTime? sentUnixTime;

  /// Time when the message was delivered. Only set for sent messages.
  final UtcDateTime? deliveredUnixTime;

  /// Time when the message was seen. Only set for sent messages.
  final UtcDateTime? seenUnixTime;

  MessageEntry({
    required this.localId,
    required this.remoteAccountId,
    required this.message,
    required this.localUnixTime,
    required this.messageState,
    this.messageNumber,
    this.messageId,
    this.sentUnixTime,
    this.deliveredUnixTime,
    this.seenUnixTime,
  });

  UtcDateTime userVisibleTime() => sentUnixTime ?? localUnixTime;

  @override
  String toString() {
    return "MessageEntry(localId: $localId, remoteAccountId: $remoteAccountId, message: $message, messageState: $messageState, messageNumber: $messageNumber, messageId: $messageId, sentUnixTime: $sentUnixTime)";
  }
}

enum MessageState {
  // Sent message

  /// Message is waiting to be sent to server.
  sentPendingSending(_VALUE_SENT_PENDING_SENDING),

  /// Message sent to server.
  sent(_VALUE_SENT),

  /// Message sending failed.
  sentSendingError(_VALUE_SENT_SENDING_ERROR),

  /// Message delivered to receiver.
  sentDelivered(_VALUE_SENT_DELIVERED),

  /// Message seen by receiver.
  sentSeen(_VALUE_SENT_SEEN),

  /// Message delivery failed.
  sentDeliveryFailed(_VALUE_SENT_DELIVERY_FAILED),

  /// Message delivery failed and it was resent.
  sentDeliveryFailedAndResent(_VALUE_SENT_DELIVERY_FAILED_AND_RESENT),

  // Received message

  /// Message received successfully.
  received(_VALUE_RECEIVED),

  /// Message received, but decrypting failed.
  receivedAndDecryptingFailed(_VALUE_RECEIVED_AND_DECRYPTING_FAILED),

  /// Message received, but public key download failed.
  receivedAndPublicKeyDownloadFailed(_VALUE_RECEIVED_AND_PUBLIC_KEY_DOWNLOAD_FAILED),

  /// Message received and marked as seen locally (before API call).
  receivedAndSeenLocally(_VALUE_RECEIVED_AND_SEEN_LOCALLY),

  /// Message received and marked as seen (after API call).
  receivedAndSeen(_VALUE_RECEIVED_AND_SEEN),

  // Info messages which client automatically adds

  /// Initial public key for match received
  infoMatchFirstPublicKeyReceived(_VALUE_INFO_MATCH_FIRST_PUBLIC_KEY_RECEIVED),
  infoMatchPublicKeyChanged(_VALUE_INFO_MATCH_PUBLIC_KEY_CHANGED);

  static const int _VALUE_SENT_PENDING_SENDING = 0;
  static const int _VALUE_SENT = 1;
  static const int _VALUE_SENT_SENDING_ERROR = 2;
  static const int _VALUE_SENT_DELIVERED = 3;
  static const int _VALUE_SENT_SEEN = 4;
  static const int _VALUE_SENT_DELIVERY_FAILED = 5;
  static const int _VALUE_SENT_DELIVERY_FAILED_AND_RESENT = 6;

  static const int _VALUE_RECEIVED = 20;
  static const int _VALUE_RECEIVED_AND_DECRYPTING_FAILED = 21;
  static const int _VALUE_RECEIVED_AND_PUBLIC_KEY_DOWNLOAD_FAILED = 22;
  static const int _VALUE_RECEIVED_AND_SEEN_LOCALLY = 23;
  static const int _VALUE_RECEIVED_AND_SEEN = 24;

  static const int _VALUE_INFO_MATCH_FIRST_PUBLIC_KEY_RECEIVED = 40;
  static const int _VALUE_INFO_MATCH_PUBLIC_KEY_CHANGED = 41;

  static const int MIN_VALUE_SENT_MESSAGE = _VALUE_SENT_PENDING_SENDING;
  static const int MAX_VALUE_SENT_MESSAGE = _VALUE_SENT_DELIVERY_FAILED_AND_RESENT;

  static const int MIN_VALUE_RECEIVED_MESSAGE = _VALUE_RECEIVED;
  static const int MAX_VALUE_RECEIVED_MESSAGE = _VALUE_RECEIVED_AND_SEEN;

  const MessageState(this.number);
  final int number;

  static MessageState? fromInt(int value) {
    return switch (value) {
      _VALUE_SENT_PENDING_SENDING => sentPendingSending,
      _VALUE_SENT => sent,
      _VALUE_SENT_DELIVERED => sentDelivered,
      _VALUE_SENT_SEEN => sentSeen,
      _VALUE_SENT_SENDING_ERROR => sentSendingError,
      _VALUE_SENT_DELIVERY_FAILED => sentDeliveryFailed,
      _VALUE_SENT_DELIVERY_FAILED_AND_RESENT => sentDeliveryFailedAndResent,
      _VALUE_RECEIVED => received,
      _VALUE_RECEIVED_AND_DECRYPTING_FAILED => receivedAndDecryptingFailed,
      _VALUE_RECEIVED_AND_PUBLIC_KEY_DOWNLOAD_FAILED => receivedAndPublicKeyDownloadFailed,
      _VALUE_RECEIVED_AND_SEEN_LOCALLY => receivedAndSeenLocally,
      _VALUE_RECEIVED_AND_SEEN => receivedAndSeen,
      _VALUE_INFO_MATCH_FIRST_PUBLIC_KEY_RECEIVED => infoMatchFirstPublicKeyReceived,
      _VALUE_INFO_MATCH_PUBLIC_KEY_CHANGED => infoMatchPublicKeyChanged,
      _ => null,
    };
  }

  bool isSent() {
    return toSentState() != null;
  }

  SentMessageState? toSentState() {
    switch (this) {
      case sentPendingSending:
        return SentMessageState.pending;
      case sent:
        return SentMessageState.sent;
      case sentDelivered:
        return SentMessageState.delivered;
      case sentSeen:
        return SentMessageState.seen;
      case sentDeliveryFailed:
        return SentMessageState.deliveryFailed;
      case sentDeliveryFailedAndResent:
        return SentMessageState.deliveryFailedAndResent;
      case sentSendingError:
        return SentMessageState.sendingError;
      case received ||
          receivedAndDecryptingFailed ||
          receivedAndPublicKeyDownloadFailed ||
          receivedAndSeenLocally ||
          receivedAndSeen ||
          infoMatchFirstPublicKeyReceived ||
          infoMatchPublicKeyChanged:
        return null;
    }
  }

  bool isReceived() {
    return toReceivedState() != null;
  }

  ReceivedMessageState? toReceivedState() {
    switch (this) {
      case received:
        return ReceivedMessageState.received;
      case receivedAndDecryptingFailed:
        return ReceivedMessageState.decryptingFailed;
      case receivedAndPublicKeyDownloadFailed:
        return ReceivedMessageState.publicKeyDownloadFailed;
      case receivedAndSeenLocally:
        return ReceivedMessageState.receivedAndSeenLocally;
      case receivedAndSeen:
        return ReceivedMessageState.receivedAndSeen;
      case sentPendingSending ||
          sent ||
          sentDelivered ||
          sentSeen ||
          sentDeliveryFailed ||
          sentDeliveryFailedAndResent ||
          sentSendingError ||
          infoMatchFirstPublicKeyReceived ||
          infoMatchPublicKeyChanged:
        return null;
    }
  }

  InfoMessageState? toInfoState() {
    switch (this) {
      case infoMatchFirstPublicKeyReceived:
        return InfoMessageState.infoMatchFirstPublicKeyReceived;
      case infoMatchPublicKeyChanged:
        return InfoMessageState.infoMatchPublicKeyChanged;
      case received ||
          receivedAndDecryptingFailed ||
          receivedAndPublicKeyDownloadFailed ||
          receivedAndSeenLocally ||
          receivedAndSeen ||
          sentPendingSending ||
          sent ||
          sentDelivered ||
          sentSeen ||
          sentDeliveryFailed ||
          sentDeliveryFailedAndResent ||
          sentSendingError:
        return null;
    }
  }
}

enum SentMessageState {
  /// Waiting to be sent to server.
  pending,

  /// Sent to server, but not yet received by the other user.
  sent,

  /// Delivered to receiver.
  delivered,

  /// Seen by receiver.
  seen,

  /// Message delivery failed.
  deliveryFailed,

  /// Message delivery failed and it was resent.
  deliveryFailedAndResent,

  /// Sending failed.
  sendingError;

  bool sendingFailed() {
    return this == sendingError;
  }

  MessageState toDbState() {
    switch (this) {
      case pending:
        return MessageState.sentPendingSending;
      case sent:
        return MessageState.sent;
      case delivered:
        return MessageState.sentDelivered;
      case seen:
        return MessageState.sentSeen;
      case deliveryFailed:
        return MessageState.sentDeliveryFailed;
      case deliveryFailedAndResent:
        return MessageState.sentDeliveryFailedAndResent;
      case sendingError:
        return MessageState.sentSendingError;
    }
  }
}

enum ReceivedMessageState {
  /// Received successfully
  received,

  /// Received, but decrypting failed
  decryptingFailed,

  /// Received, but public key download failed.
  publicKeyDownloadFailed,

  /// Received and marked as seen locally (before API call).
  receivedAndSeenLocally,

  /// Received and marked as seen (after API call).
  receivedAndSeen;

  bool isError() {
    return this == decryptingFailed || this == publicKeyDownloadFailed;
  }

  const ReceivedMessageState();

  MessageState toDbState() {
    switch (this) {
      case received:
        return MessageState.received;
      case decryptingFailed:
        return MessageState.receivedAndDecryptingFailed;
      case publicKeyDownloadFailed:
        return MessageState.receivedAndPublicKeyDownloadFailed;
      case receivedAndSeenLocally:
        return MessageState.receivedAndSeenLocally;
      case receivedAndSeen:
        return MessageState.receivedAndSeen;
    }
  }
}

enum InfoMessageState {
  infoMatchFirstPublicKeyReceived,
  infoMatchPublicKeyChanged;

  const InfoMessageState();

  MessageState toDbState() {
    switch (this) {
      case infoMatchFirstPublicKeyReceived:
        return MessageState.infoMatchFirstPublicKeyReceived;
      case infoMatchPublicKeyChanged:
        return MessageState.infoMatchPublicKeyChanged;
    }
  }
}

class NewMessageEntry {
  final AccountId remoteAccountId;
  final Message? message;

  /// Local/client time when message entry is inserted to database.
  final UtcDateTime localUnixTime;
  final MessageState messageState;

  /// Null if message was sent.
  final ReceivedMessageState? receivedMessageState;

  /// Conversation specific number for the message. Server sets this value.
  final MessageNumber? messageNumber;

  /// Message sender generated UUID for the message.
  final MessageId? messageId;

  /// Time when the message was sent. Server sets this falue.
  final UtcDateTime? sentUnixTime;

  /// Backend signed PGP message. Server sets this falue.
  final Uint8List? backendSignedPgpMessage;

  /// Symmetric encryption key for PGP message from sender.
  final Uint8List? symmetricMessageEncryptionKey;

  NewMessageEntry({
    required this.remoteAccountId,
    required this.message,
    required this.localUnixTime,
    required this.messageState,
    this.receivedMessageState,
    this.messageNumber,
    this.messageId,
    this.sentUnixTime,
    this.backendSignedPgpMessage,
    this.symmetricMessageEncryptionKey,
  });

  @override
  String toString() {
    return "NewMessageEntry(remoteAccountId: $remoteAccountId, message: $message, messageState: $messageState, receivedMessageState: $receivedMessageState, messageNumber: $messageNumber, messageId: $messageId, sentUnixTime: $sentUnixTime, backendSignedPgpMessage: $backendSignedPgpMessage)";
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

class PrivateKeyBytes {
  final Uint8List data;
  const PrivateKeyBytes({required this.data});
}

class PublicKeyBytes {
  final Uint8List data;
  const PublicKeyBytes({required this.data});
}

class AllKeyData {
  final PrivateKeyBytes private;
  final PublicKeyBytes public;
  final PublicKeyId publicKeyId;
  final PublicKeyId publicKeyIdOnServer;
  const AllKeyData({
    required this.private,
    required this.public,
    required this.publicKeyId,
    required this.publicKeyIdOnServer,
  });
}

class ForeignPublicKey {
  final Uint8List data;
  final PublicKeyId id;
  const ForeignPublicKey({required this.data, required this.id});
}
