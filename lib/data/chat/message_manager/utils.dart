import 'package:database/database.dart';

sealed class MessageSendingEvent {
  const MessageSendingEvent();
}

class SavedToLocalDb extends MessageSendingEvent {
  const SavedToLocalDb();
}

enum MessageSendingErrorDetails {
  tooManyPendingMessages,
  recipientBlockedSenderOrRecipientNotFound,

  /// HTTP 429 Too Many Requests (error is already shown to user)
  rateLimit;

  ResendFailedError toResendFailedError() {
    switch (this) {
      case tooManyPendingMessages:
        return ResendFailedError.tooManyPendingMessages;
      case recipientBlockedSenderOrRecipientNotFound:
        return ResendFailedError.recipientBlockedSenderOrRecipientNotFound;
      case rateLimit:
        return ResendFailedError.rateLimit;
    }
  }

  ResendDeliveryFailedError toResendDeliveryFailedError() {
    switch (this) {
      case tooManyPendingMessages:
        return ResendDeliveryFailedError.tooManyPendingMessages;
      case recipientBlockedSenderOrRecipientNotFound:
        return ResendDeliveryFailedError.recipientBlockedSenderOrRecipientNotFound;
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
  recipientBlockedSenderOrRecipientNotFound,

  /// HTTP 429 Too Many Requests (error is already shown to user)
  rateLimit,
}

enum ResendDeliveryFailedError {
  unspecifiedError,
  tooManyPendingMessages,
  recipientBlockedSenderOrRecipientNotFound,

  /// HTTP 429 Too Many Requests (error is already shown to user)
  rateLimit,
}
