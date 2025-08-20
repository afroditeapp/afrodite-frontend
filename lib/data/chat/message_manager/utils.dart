import 'package:database/database.dart';

sealed class MessageSendingEvent {
  const MessageSendingEvent();
}

class SavedToLocalDb extends MessageSendingEvent {
  const SavedToLocalDb();
}

enum MessageSendingErrorDetails {
  tooManyPendingMessages,
  receiverBlockedSenderOrReceiverNotFound;

  ResendFailedError toResendFailedError() {
    switch (this) {
      case tooManyPendingMessages:
        return ResendFailedError.tooManyPendingMessages;
      case receiverBlockedSenderOrReceiverNotFound:
        return ResendFailedError.receiverBlockedSenderOrReceiverNotFound;
    }
  }
}

/// Error happened before the message was saved successfully
class ErrorBeforeMessageSaving extends MessageSendingEvent {
  const ErrorBeforeMessageSaving();
}

class ErrorAfterMessageSaving extends MessageSendingEvent {
  final LocalMessageId id;
  final MessageSendingErrorDetails? details;
  const ErrorAfterMessageSaving(this.id, [this.details]);
}

enum ResendFailedError {
  unspecifiedError,
  isActuallySentSuccessfully,
  tooManyPendingMessages,
  receiverBlockedSenderOrReceiverNotFound,
}
