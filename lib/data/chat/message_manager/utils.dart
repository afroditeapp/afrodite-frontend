import 'package:database/database.dart';

sealed class MessageSendingEvent {
  const MessageSendingEvent();
}

class SavedToLocalDb extends MessageSendingEvent {
  const SavedToLocalDb();
}

enum MessageSendingErrorDetails {
  tooManyPendingMessages,
  receiverBlockedSenderOrReceiverNotFound,

  /// HTTP 429 Too Many Requests (error is already shown to user)
  rateLimit;

  ResendFailedError toResendFailedError() {
    switch (this) {
      case tooManyPendingMessages:
        return ResendFailedError.tooManyPendingMessages;
      case receiverBlockedSenderOrReceiverNotFound:
        return ResendFailedError.receiverBlockedSenderOrReceiverNotFound;
      case rateLimit:
        return ResendFailedError.rateLimit;
    }
  }

  ResendDeliveryFailedError toResendDeliveryFailedError() {
    switch (this) {
      case tooManyPendingMessages:
        return ResendDeliveryFailedError.tooManyPendingMessages;
      case receiverBlockedSenderOrReceiverNotFound:
        return ResendDeliveryFailedError.receiverBlockedSenderOrReceiverNotFound;
      case rateLimit:
        return ResendDeliveryFailedError.rateLimit;
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

  /// HTTP 429 Too Many Requests (error is already shown to user)
  rateLimit,
}

enum ResendDeliveryFailedError {
  unspecifiedError,
  tooManyPendingMessages,
  receiverBlockedSenderOrReceiverNotFound,

  /// HTTP 429 Too Many Requests (error is already shown to user)
  rateLimit,
}
