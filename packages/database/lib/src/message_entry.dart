


import 'dart:typed_data';

import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class MessageEntry {
  /// Local database ID of the message.
  final LocalMessageId localId;

  final AccountId localAccountId;
  final AccountId remoteAccountId;
  /// For sent messages this is normal text. For received messages this can
  /// be normal text or when in error state empty text.
  final String messageText;
  /// Local/client time when message entry is inserted to database.
  final UtcDateTime localUnixTime;
  final MessageState messageState;
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
      required this.messageState,
      this.messageNumber,
      this.unixTime,
    }
  );

  @override
  String toString() {
    return "MessageEntry(localId: $localId, localAccountId: $localAccountId, remoteAccountId: $remoteAccountId, messageText: $messageText, messageState: $messageState, messageNumber: $messageNumber, unixTime: $unixTime)";
  }
}

enum MessageState {
  // Sent message

  /// Message is waiting to be sent to server.
  pendingSending(_VALUE_PENDING_SENDING),
  /// Message sent to server.
  sent(_VALUE_SENT),
  /// Message sending failed.
  sendingError(_VALUE_SENDING_ERROR),

  // Received message

  /// Message received successfully.
  received(_VALUE_RECEIVED),
  /// Message received, but decrypting failed.
  receivedAndDecryptingFailed(_VALUE_RECEIVED_AND_DECRYPTING_FAILED),
  /// Message received, but message type is unknown.
  receivedAndUnknownMessageType(_VALUE_RECEIVED_AND_UNKNOWN_MESSAGE_TYPE),
  /// Message received, but public key download failed.
  receivedAndPublicKeyDownloadFailed(_VALUE_RECEIVED_AND_PUBLIC_KEY_DOWNLOAD_FAILED),

  // Info messages which client automatically adds

  /// Initial public key for match received
  infoMatchFirstPublicKeyReceived(_VALUE_INFO_MATCH_FIRST_PUBLIC_KEY_RECEIVED),
  infoMatchPublicKeyChanged(_VALUE_INFO_MATCH_PUBLIC_KEY_CHANGED);

  static const int _VALUE_PENDING_SENDING = 0;
  static const int _VALUE_SENT = 1;
  static const int _VALUE_SENDING_ERROR = 2;

  static const int _VALUE_RECEIVED = 20;
  static const int _VALUE_RECEIVED_AND_DECRYPTING_FAILED = 21;
  static const int _VALUE_RECEIVED_AND_UNKNOWN_MESSAGE_TYPE = 22;
  static const int _VALUE_RECEIVED_AND_PUBLIC_KEY_DOWNLOAD_FAILED = 23;

  static const int _VALUE_INFO_MATCH_FIRST_PUBLIC_KEY_RECEIVED = 40;
  static const int _VALUE_INFO_MATCH_PUBLIC_KEY_CHANGED = 41;

  static const int MIN_VALUE_SENT_MESSAGE = _VALUE_PENDING_SENDING;
  static const int MAX_VALUE_SENT_MESSAGE = _VALUE_SENDING_ERROR;

  const MessageState(this.number);
  final int number;

  static MessageState? fromInt(int value) {
    return switch (value) {
      _VALUE_PENDING_SENDING => pendingSending,
      _VALUE_SENT => sent,
      _VALUE_SENDING_ERROR => sendingError,
      _VALUE_RECEIVED => received,
      _VALUE_RECEIVED_AND_DECRYPTING_FAILED => receivedAndDecryptingFailed,
      _VALUE_RECEIVED_AND_UNKNOWN_MESSAGE_TYPE => receivedAndUnknownMessageType,
      _VALUE_RECEIVED_AND_PUBLIC_KEY_DOWNLOAD_FAILED => receivedAndPublicKeyDownloadFailed,
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
      case pendingSending:
        return SentMessageState.pending;
      case sent:
        return SentMessageState.sent;
      case sendingError:
        return SentMessageState.sendingError;
      case received ||
        receivedAndDecryptingFailed ||
        receivedAndUnknownMessageType ||
        receivedAndPublicKeyDownloadFailed ||
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
      case receivedAndUnknownMessageType:
        return ReceivedMessageState.unknownMessageType;
      case receivedAndPublicKeyDownloadFailed:
        return ReceivedMessageState.publicKeyDownloadFailed;
      case pendingSending ||
        sent ||
        sendingError ||
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
        receivedAndUnknownMessageType ||
        receivedAndPublicKeyDownloadFailed ||
        pendingSending ||
        sent ||
        sendingError:
        return null;
    }
  }
}

enum SentMessageState {
  /// Waiting to be sent to server.
  pending,
  /// Sent to server, but not yet received by the other user.
  sent,
  /// Sending failed.
  sendingError;

  bool isError() {
    return this == sendingError;
  }

  MessageState toDbState() {
    switch (this) {
      case pending:
        return MessageState.pendingSending;
      case sent:
        return MessageState.sent;
      case sendingError:
        return MessageState.sendingError;
    }
  }
}

enum ReceivedMessageState {
  /// Received successfully
  received,
  /// Received, but decrypting failed
  decryptingFailed,
  /// Received, but message type is unknown.
  unknownMessageType,
  /// Received, but public key download failed.
  publicKeyDownloadFailed;

  bool isError() {
    return this == decryptingFailed ||
      this == unknownMessageType ||
      this == publicKeyDownloadFailed;
  }

  const ReceivedMessageState();

  MessageState toDbState() {
    switch (this) {
      case received:
        return MessageState.received;
      case decryptingFailed:
        return MessageState.receivedAndDecryptingFailed;
      case unknownMessageType:
        return MessageState.receivedAndUnknownMessageType;
      case publicKeyDownloadFailed:
        return MessageState.receivedAndPublicKeyDownloadFailed;
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
  final AccountId localAccountId;
  final AccountId remoteAccountId;
  final String messageText;
  /// Local/client time when message entry is inserted to database.
  final UtcDateTime localUnixTime;
  final MessageState messageState;
  /// Null if message was sent.
  final ReceivedMessageState? receivedMessageState;
  /// Message number in a conversation. Server sets this value.
  final MessageNumber? messageNumber;
  /// Time since Unix epoch. Server sets this falue.
  final UtcDateTime? unixTime;
  /// Backend signed PGP message. Server sets this falue.
  final Uint8List? backendSignedPgpMessage;
  /// Symmetric encryption key for PGP message from sender.
  final Uint8List? symmetricMessageEncryptionKey;

  NewMessageEntry(
    {
      required this.localAccountId,
      required this.remoteAccountId,
      required this.messageText,
      required this.localUnixTime,
      required this.messageState,
      this.receivedMessageState,
      this.messageNumber,
      this.unixTime,
      this.backendSignedPgpMessage,
      this.symmetricMessageEncryptionKey,
    }
  );

  @override
  String toString() {
    return "NewMessageEntry(localAccountId: $localAccountId, remoteAccountId: $remoteAccountId, messageText: $messageText, messageState: $messageState, receivedMessageState: $receivedMessageState, messageNumber: $messageNumber, unixTime: $unixTime, backendSignedPgpMessage: $backendSignedPgpMessage)";
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
