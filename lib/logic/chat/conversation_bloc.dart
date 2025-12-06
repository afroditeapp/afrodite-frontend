import "dart:async";

import "package:app/api/server_connection_manager.dart";
import "package:app/data/account_repository.dart";
import "package:app/data/chat/message_manager/utils.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:app/data/chat/message_manager.dart";
import "package:app/data/chat_repository.dart";
import "package:app/data/profile_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/chat/conversation_bloc.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";

final _log = Logger("ConversationBloc");

sealed class ConversationEvent {}

class InitEvent extends ConversationEvent {}

class SendMessageTo extends ConversationEvent {
  final AccountId accountId;
  final Message message;
  final Completer<bool> completer;
  SendMessageTo(this.accountId, this.message, this.completer);
}

class HandleProfileChange extends ConversationEvent {
  final ProfileChange change;
  HandleProfileChange(this.change);
}

class UpdateIsInMatches extends ConversationEvent {
  final bool value;
  UpdateIsInMatches(this.value);
}

class MessageCountChanged extends ConversationEvent {
  final int newMessageCount;
  final ConversationChangeType? changeInfo;
  MessageCountChanged(this.newMessageCount, this.changeInfo);
}

class BlockProfile extends ConversationEvent {
  final AccountId accountId;
  BlockProfile(this.accountId);
}

class RemoveSendFailedMessage extends ConversationEvent {
  final LocalMessageId id;
  RemoveSendFailedMessage(this.id);
}

class ResendSendFailedMessage extends ConversationEvent {
  final LocalMessageId id;
  ResendSendFailedMessage(this.id);
}

class RetryPublicKeyDownload extends ConversationEvent {
  final LocalMessageId id;
  RetryPublicKeyDownload(this.id);
}

abstract class ConversationDataProvider {
  Stream<bool> isInMatchesStream(AccountId accountId);
  Future<bool> isInSentBlocks(AccountId accountId);
  Future<bool> sendBlockTo(AccountId accountId);
  Stream<MessageSendingEvent> sendMessageTo(AccountId accountId, Message message);
  Stream<(int, ConversationChanged?)> getMessageCountAndChanges(AccountId match);

  Future<Result<(), DeleteSendFailedError>> deleteSendFailedMessage(LocalMessageId localId);
  Future<Result<(), ResendFailedError>> resendSendFailedMessage(LocalMessageId localId);
  Future<Result<(), RetryPublicKeyDownloadError>> retryPublicKeyDownload(LocalMessageId localId);
}

class DefaultConversationDataProvider extends ConversationDataProvider {
  final ChatRepository chat;
  DefaultConversationDataProvider(this.chat);

  @override
  Stream<bool> isInMatchesStream(AccountId accountId) => chat.isInMatchesStream(accountId);

  @override
  Future<bool> isInSentBlocks(AccountId accountId) => chat.isInSentBlocks(accountId);

  @override
  Future<bool> sendBlockTo(AccountId accountId) => chat.sendBlockTo(accountId);

  @override
  Stream<MessageSendingEvent> sendMessageTo(AccountId accountId, Message message) {
    return chat.sendMessageTo(accountId, message);
  }

  @override
  Stream<(int, ConversationChanged?)> getMessageCountAndChanges(AccountId match) {
    return chat.getMessageCountAndChanges(match);
  }

  @override
  Future<Result<(), DeleteSendFailedError>> deleteSendFailedMessage(LocalMessageId localId) {
    return chat.deleteSendFailedMessage(localId);
  }

  @override
  Future<Result<(), ResendFailedError>> resendSendFailedMessage(LocalMessageId localId) {
    return chat.resendSendFailedMessage(localId);
  }

  @override
  Future<Result<(), RetryPublicKeyDownloadError>> retryPublicKeyDownload(LocalMessageId localId) {
    return chat.retryPublicKeyDownload(localId);
  }
}

class ConversationBloc extends Bloc<ConversationEvent, ConversationData> with ActionRunner {
  final ConversationDataProvider dataProvider;
  final AccountId currentUser;
  final ProfileRepository profile;
  final ChatRepository chat;
  final AccountDatabaseManager db;
  final ApiManager api;
  final AccountRepository account;

  StreamSubscription<(int, ConversationChanged?)>? _messageCountSubscription;
  StreamSubscription<ProfileChange>? _profileChangeSubscription;
  StreamSubscription<bool>? _isInMatchesSubscription;

  ConversationBloc(RepositoryInstances r, AccountId messageSenderAccountId, this.dataProvider)
    : currentUser = r.accountId,
      profile = r.profile,
      chat = r.chat,
      db = r.accountDb,
      api = r.api,
      account = r.account,
      super(ConversationData(accountId: messageSenderAccountId)) {
    on<InitEvent>((data, emit) async {
      _log.info("Set conversation bloc initial state");

      final isBlocked = await dataProvider.isInSentBlocks(state.accountId);

      await profile.resetUnreadMessagesCount(state.accountId);

      // Send check online status request when conversation is opened
      chat.checkOnlineStatusManager.handleCheckOnlineStatusRequest(state.accountId);

      await markMessagesAsSeen();

      emit(state.copyWith(isBlocked: isBlocked));
    });
    on<HandleProfileChange>((data, emit) async {
      final change = data.change;
      switch (change) {
        case ProfileBlocked():
          {
            if (change.profile == state.accountId) {
              emit(state.copyWith(isBlocked: true));
            }
          }
        case ProfileNowPrivate() ||
            ProfileUnblocked() ||
            ConversationChanged() ||
            ReloadMainProfileView() ||
            ProfileFavoriteStatusChange():
          {}
      }
    });
    on<UpdateIsInMatches>((data, emit) {
      emit(state.copyWith(isMatch: data.value));
    });
    on<BlockProfile>((data, emit) async {
      await runOnce(() async {
        if (await dataProvider.sendBlockTo(state.accountId)) {
          emit(state.copyWith(isBlocked: true));
        }
      });
    });
    on<SendMessageTo>((data, emit) async {
      emit(state.copyWith(isMessageSendingInProgress: true));

      var savedToDb = false;

      await for (final e in dataProvider.sendMessageTo(data.accountId, data.message)) {
        switch (e) {
          case SavedToLocalDb():
            savedToDb = true;
          case ErrorBeforeMessageSaving():
            showSnackBar(R.strings.generic_error);
          case ErrorAfterMessageSaving(:final details):
            switch (details) {
              case null:
                showSnackBar(R.strings.generic_error_occurred);
              case MessageSendingErrorDetails.tooManyPendingMessages:
                showSnackBar(R.strings.conversation_screen_message_too_many_pending_messages);
              case MessageSendingErrorDetails.receiverBlockedSenderOrReceiverNotFound:
                showSnackBar(
                  R
                      .strings
                      .conversation_screen_message_error_receiver_blocked_sender_or_receiver_not_found,
                );
            }
        }
      }

      data.completer.complete(savedToDb);
      emit(state.copyWith(isMessageSendingInProgress: false));
    }, transformer: sequential());
    on<RemoveSendFailedMessage>((data, emit) async {
      emit(state.copyWith(isMessageRemovingInProgress: true));

      switch (await dataProvider.deleteSendFailedMessage(data.id)) {
        case Ok():
          ();
        case Err(:final e):
          switch (e) {
            case DeleteSendFailedError.unspecifiedError:
              showSnackBar(R.strings.generic_error_occurred);
            case DeleteSendFailedError.isActuallySentSuccessfully:
              showSnackBar(
                R.strings.conversation_screen_message_error_is_actually_sent_successfully,
              );
          }
      }

      emit(state.copyWith(isMessageRemovingInProgress: false));
    }, transformer: sequential());
    on<ResendSendFailedMessage>((data, emit) async {
      emit(state.copyWith(isMessageResendingInProgress: true));

      switch (await dataProvider.resendSendFailedMessage(data.id)) {
        case Ok():
          ();
        case Err(:final e):
          switch (e) {
            case ResendFailedError.unspecifiedError:
              showSnackBar(R.strings.generic_error_occurred);
            case ResendFailedError.isActuallySentSuccessfully:
              showSnackBar(
                R.strings.conversation_screen_message_error_is_actually_sent_successfully,
              );
            case ResendFailedError.tooManyPendingMessages:
              showSnackBar(R.strings.conversation_screen_message_too_many_pending_messages);
            case ResendFailedError.receiverBlockedSenderOrReceiverNotFound:
              showSnackBar(
                R
                    .strings
                    .conversation_screen_message_error_receiver_blocked_sender_or_receiver_not_found,
              );
          }
      }

      emit(state.copyWith(isMessageResendingInProgress: false));
    }, transformer: sequential());
    on<RetryPublicKeyDownload>((data, emit) async {
      emit(state.copyWith(isRetryPublicKeyDownloadInProgress: true));

      switch (await dataProvider.retryPublicKeyDownload(data.id)) {
        case Ok():
          ();
        case Err(:final e):
          switch (e) {
            case RetryPublicKeyDownloadError.unspecifiedError:
              showSnackBar(R.strings.generic_error_occurred);
          }
      }

      emit(state.copyWith(isRetryPublicKeyDownloadInProgress: false));
    }, transformer: sequential());
    on<MessageCountChanged>((data, emit) async {
      await profile.resetUnreadMessagesCount(state.accountId);
    }, transformer: sequential());

    _profileChangeSubscription = profile.profileChanges.listen((event) {
      add(HandleProfileChange(event));
    });

    _messageCountSubscription = dataProvider.getMessageCountAndChanges(state.accountId).listen((
      countAndEvent,
    ) {
      final (newMessageCount, event) = countAndEvent;
      add(MessageCountChanged(newMessageCount, event?.change));
    });

    _isInMatchesSubscription = dataProvider.isInMatchesStream(state.accountId).listen((value) {
      add(UpdateIsInMatches(value));
    });

    add(InitEvent());
  }

  Future<void> markMessagesAsSeen() async {
    final privacySettings = await db.accountData((db) => db.privacy.getChatPrivacySettings()).ok();
    final messageSeenEnabled =
        (account.clientFeaturesConfigValue.chat?.messageStateSeen ?? false) &&
        (privacySettings?.messageStateSent ?? false);
    if (!messageSeenEnabled) {
      final allMessages = await db
          .accountData((db) => db.message.getSuccessfullyReceivedAndNotSeen(state.accountId))
          .ok();

      if (allMessages == null || allMessages.isEmpty) {
        return;
      }

      for (final message in allMessages) {
        if (message.messageState == MessageState.received) {
          await db.accountAction(
            (db) => db.message.updateStateToReceivedAndSeenLocally(message.localId),
          );
        }
      }

      return;
    }

    final allMessages = await db
        .accountData(
          (db) => db.message.getSuccessfullyReceivedAndSeenStateChangeToServerNotYetDone(
            state.accountId,
          ),
        )
        .ok();

    if (allMessages == null || allMessages.isEmpty) {
      return;
    }

    for (final message in allMessages) {
      if (message.messageState == MessageState.received) {
        await db.accountAction(
          (db) => db.message.updateStateToReceivedAndSeenLocally(message.localId),
        );
      }
    }

    await markMessageEntryListSeen(api, db, allMessages);
  }

  @override
  Future<void> close() async {
    await _messageCountSubscription?.cancel();
    await _profileChangeSubscription?.cancel();
    await _isInMatchesSubscription?.cancel();
    return super.close();
  }
}

Future<void> markMessageEntryListSeen(
  ApiManager api,
  AccountDatabaseManager db,
  List<MessageEntry> allMessages,
) async {
  final messageIds = allMessages
      .map((m) {
        final id = m.messageId;
        final mn = m.messageNumber;
        final sender = m.remoteAccountId;
        if (id == null || mn == null) {
          return null;
        }
        return SeenMessage(id: id, sender: sender, mn: mn);
      })
      .whereType<SeenMessage>()
      .toList();

  if (messageIds.isEmpty) {
    return;
  }

  final result = await api.chatAction(
    (api) => api.postMarkMessagesAsSeen(SeenMessageList(messages: messageIds)),
  );

  if (result.isOk()) {
    for (final message in allMessages) {
      await db.accountAction((db) => db.message.updateStateToReceivedAndSeen(message.localId));
    }
  }
}
