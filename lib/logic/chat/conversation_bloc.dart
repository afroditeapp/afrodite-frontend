import "dart:async";

import "package:app/data/chat/message_manager/utils.dart";
import "package:app/data/utils/repository_instances.dart";
import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:async/async.dart" show StreamExtensions;
import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:rxdart/rxdart.dart";
import 'package:utils/utils.dart';
import "package:app/data/chat/message_database_iterator.dart";
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
  SendMessageTo(this.accountId, this.message);
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

class NotifyMessageInputFieldCleared extends ConversationEvent {}

class RenderingCompleted extends ConversationEvent {
  final double height;
  RenderingCompleted(this.height);
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
  Future<List<MessageEntry>> getAllMessages(AccountId accountId);
  Stream<(int, ConversationChanged?)> getMessageCountAndChanges(AccountId match);
  Stream<MessageEntry?> getMessageWithLocalId(LocalMessageId localId);

  /// First message is the latest new message
  Future<List<MessageEntry>> getNewMessages(
    AccountId senderAccountId,
    LocalMessageId? latestCurrentMessageLocalId,
  );

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
  Future<List<MessageEntry>> getAllMessages(AccountId accountId) async {
    return await chat.getAllMessages(accountId);
  }

  @override
  Stream<(int, ConversationChanged?)> getMessageCountAndChanges(AccountId match) {
    return chat.getMessageCountAndChanges(match);
  }

  @override
  Stream<MessageEntry?> getMessageWithLocalId(LocalMessageId localId) {
    return chat.getMessageWithLocalId(localId);
  }

  @override
  Future<List<MessageEntry>> getNewMessages(
    AccountId senderAccountId,
    LocalMessageId? latestCurrentMessageLocalId,
  ) async {
    MessageDatabaseIterator messageIterator = MessageDatabaseIterator(chat.db);
    await messageIterator.switchConversation(chat.currentUser, senderAccountId);

    // Read latest messages until all new messages are read
    List<MessageEntry> newMessages = [];
    bool readMessages = true;
    while (readMessages) {
      final messages = await messageIterator.nextList();
      if (messages.isEmpty) {
        break;
      }

      for (final message in messages) {
        if (message.localId == latestCurrentMessageLocalId) {
          readMessages = false;
          break;
        } else {
          newMessages.add(message);
        }
      }
    }

    return newMessages;
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
  final RenderingManager renderingManager = RenderingManager();
  final ProfileRepository profile;

  StreamSubscription<(int, ConversationChanged?)>? _messageCountSubscription;
  StreamSubscription<ProfileChange>? _profileChangeSubscription;
  StreamSubscription<bool>? _isInMatchesSubscription;

  final BehaviorSubject<bool> _renderingSynchronizer = BehaviorSubject<bool>.seeded(false);

  ConversationBloc(RepositoryInstances r, AccountId messageSenderAccountId, this.dataProvider)
    : profile = r.profile,
      super(ConversationData(accountId: messageSenderAccountId)) {
    on<InitEvent>((data, emit) async {
      _log.info("Set conversation bloc initial state");

      final isBlocked = await dataProvider.isInSentBlocks(state.accountId);

      await profile.resetUnreadMessagesCount(state.accountId);

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

      await for (final e in dataProvider.sendMessageTo(data.accountId, data.message)) {
        switch (e) {
          case SavedToLocalDb():
            emit(state.copyWith(resetMessageInputField: true));
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
    on<NotifyMessageInputFieldCleared>((data, emit) async {
      emit(state.copyWith(resetMessageInputField: false));
    });
    on<MessageCountChanged>((data, emit) async {
      await profile.resetUnreadMessagesCount(state.accountId);

      final visibleMessages = state.visibleMessages;
      if (visibleMessages == null ||
          data.changeInfo == ConversationChangeType.messageRemoved ||
          data.changeInfo == ConversationChangeType.messageResent) {
        final initialMessages = await dataProvider.getAllMessages(state.accountId);
        final fromOldestToNewest = initialMessages.reversed.toList();
        renderingManager.initWithMessages(fromOldestToNewest);
        emit(
          state.copyWith(
            visibleMessages: ReadyVisibleMessageListUpdate(
              MessageList(fromOldestToNewest),
              null,
              data.changeInfo == ConversationChangeType.messageResent,
            ),
          ),
        );
        if (visibleMessages == null) {
          _log.info("Initial message list update done");
        } else if (data.changeInfo == ConversationChangeType.messageRemoved) {
          _log.info("Message removed and message list refreshed");
        } else if (data.changeInfo == ConversationChangeType.messageResent) {
          _log.info("Message resent and message list refreshed");
        }
        return;
      }

      if (data.newMessageCount <= renderingManager.currentMsgCount()) {
        _log.info("Skip message count change event");
        return;
      }

      final lastMsg = renderingManager.getLastMessage();
      final newMessages = await dataProvider.getNewMessages(state.accountId, lastMsg?.localId);
      renderingManager.addToBeRendered(
        newMessages.reversed,
        data.changeInfo == ConversationChangeType.messageSent,
      );

      if (state.rendererCurrentlyRendering == null) {
        _log.info("No in-progress rendering");
        final msgForRendering = renderingManager.getAndRemoveNextToBeRendered();
        if (msgForRendering != null) {
          _renderingSynchronizer.add(false);
          emit(state.copyWith(rendererCurrentlyRendering: msgForRendering));
          // Wait that rendering completes to avoid sending the same
          // messages to renderer.
          await _renderingSynchronizer.where((v) => v).firstOrNull;
        }
      }
    }, transformer: sequential());
    on<RenderingCompleted>((data, emit) {
      final renderedMsg = state.rendererCurrentlyRendering;
      if (renderedMsg == null) {
        _log.warning("Rendering completed event received but rendered message is missing");
        return;
      }

      renderingManager.appendToCurrentMessageUpdate(data.height, renderedMsg);
      final nextMsg = renderingManager.getAndRemoveNextToBeRendered();

      if (nextMsg == null) {
        _log.info("Rendering completed");
        final currentUpdate = renderingManager.resetCurrentMessageUpdateAndMoveToVisibleMessages();
        if (currentUpdate != null) {
          emit(state.copyWith(visibleMessages: currentUpdate, rendererCurrentlyRendering: null));
          _renderingSynchronizer.add(true);
        }
      } else {
        _log.info("Continue rendering");
        emit(state.copyWith(rendererCurrentlyRendering: nextMsg));
      }
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

  @override
  Future<void> close() async {
    await _messageCountSubscription?.cancel();
    await _profileChangeSubscription?.cancel();
    await _isInMatchesSubscription?.cancel();
    return super.close();
  }
}

class RenderingManager {
  final List<MessageEntry> visibleMessages = [];

  /// Rendered messages are gathered here before they are moved to
  /// visible messages.
  ReadyVisibleMessageListUpdate? currentMessagesUpdate;

  final List<EntryAndJumpInfo> toBeRendered = [];

  void initWithMessages(Iterable<MessageEntry> messages) {
    visibleMessages.clear();
    visibleMessages.addAll(messages);
  }

  /// Sets last message's jumpToLatestMessage value to `jumpToLatestMessage`.
  void addToBeRendered(Iterable<MessageEntry> toBeRendered, bool jumpToLatestMessage) {
    final messages = [...toBeRendered].map((msg) {
      return EntryAndJumpInfo(msg, false);
    }).toList();

    if (messages.isNotEmpty) {
      final lastI = messages.length - 1;
      messages[lastI] = EntryAndJumpInfo(messages[lastI].entry, jumpToLatestMessage);
    }

    this.toBeRendered.addAll(messages);
  }

  EntryAndJumpInfo? getAndRemoveNextToBeRendered() {
    if (toBeRendered.isEmpty) {
      return null;
    }
    return toBeRendered.removeAt(0);
  }

  MessageEntry? getLastMessage() {
    if (toBeRendered.isEmpty) {
      final currentUpdate = currentMessagesUpdate;
      if (currentUpdate != null && currentUpdate.messages.messages.isNotEmpty) {
        return currentUpdate.messages.messages.lastOrNull;
      } else {
        return visibleMessages.lastOrNull;
      }
    } else {
      return toBeRendered.lastOrNull?.entry;
    }
  }

  void appendToCurrentMessageUpdate(double height, EntryAndJumpInfo renderedMsg) {
    final currentUpdate = currentMessagesUpdate;
    if (currentUpdate == null) {
      currentMessagesUpdate = ReadyVisibleMessageListUpdate(
        MessageList([renderedMsg.entry]),
        height,
        renderedMsg.jumpToLatestMessage,
      );
    } else {
      final bool jmp;
      if (currentUpdate.jumpToLatestMessage) {
        jmp = true;
      } else {
        jmp = renderedMsg.jumpToLatestMessage;
      }
      currentMessagesUpdate = ReadyVisibleMessageListUpdate(
        MessageList([...currentUpdate.messages.messages, renderedMsg.entry]),
        (currentUpdate.addedHeight ?? 0) + height,
        jmp,
      );
    }
  }

  ReadyVisibleMessageListUpdate? resetCurrentMessageUpdateAndMoveToVisibleMessages() {
    final currentUpdate = currentMessagesUpdate;
    if (currentUpdate == null) {
      _log.error("Rendered messages not found");
      return null;
    }
    currentMessagesUpdate = null;

    visibleMessages.addAll(currentUpdate.messages.messages);

    return ReadyVisibleMessageListUpdate(
      MessageList([...visibleMessages]),
      currentUpdate.addedHeight,
      currentUpdate.jumpToLatestMessage,
    );
  }

  ReadyVisibleMessageListUpdate? getCurrentMessageUpdate() {
    return currentMessagesUpdate;
  }

  int currentMsgCount() {
    return visibleMessages.length +
        (currentMessagesUpdate?.messages.messages.length ?? 0) +
        toBeRendered.length;
  }
}
