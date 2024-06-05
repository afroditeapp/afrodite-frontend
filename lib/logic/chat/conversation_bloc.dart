import "dart:async";

import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:async/async.dart";
import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/chat/message_database_iterator.dart";
import "package:pihka_frontend/data/chat_repository.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/model/freezed/logic/chat/conversation_bloc.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/immutable_list.dart";

var log = Logger("ConversationBloc");

sealed class ConversationEvent {}
class InitEvent extends ConversationEvent {}
class SendMessageTo extends ConversationEvent {
  final AccountId accountId;
  final String message;
  SendMessageTo(this.accountId, this.message);
}
class HandleProfileChange extends ConversationEvent {
  final ProfileChange change;
  HandleProfileChange(this.change);
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
class NotifyChatBoxCleared extends ConversationEvent {}
class CompleteMessageListUpdateRendering extends ConversationEvent {
  final double totalHeight;
  CompleteMessageListUpdateRendering(this.totalHeight);
}

abstract class ConversationDataProvider {
  Future<bool> isInMatches(AccountId accountId);
  Future<bool> isInSentBlocks(AccountId accountId);
  Future<bool> isInReceivedBlocks(AccountId accountId);
  Future<bool> sendBlockTo(AccountId accountId);
  Future<void> sendMessageTo(AccountId accountId, String message);
  Future<List<MessageEntry>> getAllMessages(AccountId accountId);
  Stream<(int, ConversationChanged?)> getMessageCountAndChanges(AccountId match);

  /// First message is the latest new message
  Future<List<MessageEntry>> getNewMessages(AccountId senderAccountId, int? latestCurrentMessageLocalId) async {
    MessageDatabaseIterator messageIterator = MessageDatabaseIterator();
    final currentUser = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      return [];
    }
    await messageIterator.switchConversation(currentUser, senderAccountId);

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

}

class DefaultConversationDataProvider extends ConversationDataProvider {
  final ChatRepository chat = ChatRepository.getInstance();

  @override
  Future<bool> isInMatches(AccountId accountId) => chat.isInMatches(accountId);

  @override
  Future<bool> isInSentBlocks(AccountId accountId) => chat.isInSentBlocks(accountId);

  @override
  Future<bool> isInReceivedBlocks(AccountId accountId) => chat.isInReceivedBlocks(accountId);

  @override
  Future<bool> sendBlockTo(AccountId accountId) => chat.sendBlockTo(accountId);

  @override
  Future<void> sendMessageTo(AccountId accountId, String message) async {
    await chat.sendMessageTo(accountId, message);
  }

  @override
  Future<List<MessageEntry>> getAllMessages(AccountId accountId) async {
    return await chat.getAllMessages(accountId);
  }

  @override
  Stream<(int, ConversationChanged?)> getMessageCountAndChanges(AccountId match) {
    return chat.getMessageCountAndChanges(match);
  }
}

class ConversationBloc extends Bloc<ConversationEvent, ConversationData> with ActionRunner {
  final ConversationDataProvider dataProvider;

  StreamSubscription<(int, ConversationChanged?)>? _messageCountSubscription;
  StreamSubscription<ProfileChange>? _profileChangeSubscription;

  ConversationBloc(AccountId messageSenderAccountId, this.dataProvider) :
    super(ConversationData(accountId: messageSenderAccountId)) {

    on<InitEvent>((data, emit) async {
      log.info("Set conversation bloc initial state");

      final isMatch = await dataProvider.isInMatches(state.accountId);
      final isBlocked = await dataProvider.isInSentBlocks(state.accountId) ||
        await dataProvider.isInReceivedBlocks(state.accountId);

      emit(state.copyWith(
        isMatch: isMatch,
        isBlocked: isBlocked,
      ));
    });
    on<HandleProfileChange>((data, emit) async {
      final change = data.change;
      switch (change) {
        case ProfileBlocked(): {
          if (change.profile == state.accountId) {
            emit(state.copyWith(isBlocked: true));
          }
        }
        case MatchesChanged(): {
          final isMatch = await dataProvider.isInMatches(state.accountId);
          emit(state.copyWith(isMatch: isMatch));
        }
        case ProfileNowPrivate() ||
          ProfileUnblocked() ||
          LikesChanged() ||
          ConversationChanged() ||
          MatchesChanged() ||
          ReloadMainProfileView() ||
          ProfileFavoriteStatusChange(): {}
      }
    });
    on<BlockProfile>((data, emit) async {
      await runOnce(() async {
        if (await dataProvider.sendBlockTo(state.accountId)) {
          emit(state.copyWith(
            isBlocked: true,
          ));
        }
      });
    });
    on<SendMessageTo>((data, emit) async {
      await runOnce(() async {
        await dataProvider.sendMessageTo(data.accountId, data.message);
      });
    });
    on<NotifyChatBoxCleared>((data, emit) async {
      emit(state.copyWith(
        isSendSuccessful: false,
      ));
    });
    on<MessageCountChanged>((data, emit) async {
      final pendingMessages = state.pendingMessages;
      if (pendingMessages == null) {
        final initialMessages = await dataProvider.getAllMessages(state.accountId);
        emit(state.copyWith(
          visibleMessages: ReadyVisibleMessageListUpdate(MessageList(initialMessages), null, false),
          pendingMessages: MessageList(initialMessages),
        ));
        log.info("Initial message list update done");
        return;
      }

      if (data.newMessageCount <= pendingMessages.messages.length) {
        log.info("Skip message count change event");
        return;
      }

      final currentMessages = pendingMessages.messages;
      final lastMsg = currentMessages.firstOrNull;
      final newMessages = await dataProvider.getNewMessages(state.accountId, lastMsg?.localId);
      final newMessageList = [
        ...newMessages.reversed,
        ...currentMessages,
      ];

      final messageListUpdate = MessageListUpdate(
        allMessagesList: MessageList(newMessageList),
        onlyNewMessages: MessageList(newMessages),
        jumpToLatestMessage: data.changeInfo == ConversationChangeType.messageSent,
      );

      final UnmodifiableList<MessageListUpdate> newMessageListUpdates = state.pendingMessageListUpdates.add(messageListUpdate);
      if (state.currentMessageListUpdate == null) {
        emit(state.copyWith(
          pendingMessages: messageListUpdate.allMessagesList,
          currentMessageListUpdate: newMessageListUpdates.firstOrNull,
          pendingMessageListUpdates: newMessageListUpdates.removeAt(0),
        ));
      } else {
        emit(state.copyWith(
          pendingMessages: messageListUpdate.allMessagesList,
          pendingMessageListUpdates: newMessageListUpdates,
        ));
      }
    },
      transformer: sequential(),
    );
    on<CompleteMessageListUpdateRendering>((data, emit) {
      final next = state.pendingMessageListUpdates.firstOrNull;
      final UnmodifiableList<MessageListUpdate> nextList;
      if (next == null) {
        nextList = const UnmodifiableList<MessageListUpdate>.empty();
      } else {
        nextList = state.pendingMessageListUpdates.removeAt(0);
      }
      emit(state.copyWith(
        visibleMessages: ReadyVisibleMessageListUpdate(
          state.currentMessageListUpdate?.allMessagesList ?? const MessageList([]),
          data.totalHeight,
          state.currentMessageListUpdate?.jumpToLatestMessage ?? false
        ),
        currentMessageListUpdate: next,
        pendingMessageListUpdates: nextList,
      ));
    },
      transformer: sequential(),
    );

    _profileChangeSubscription = ProfileRepository.getInstance()
      .profileChanges
      .listen((event) {
        add(HandleProfileChange(event));
      });

    _messageCountSubscription = dataProvider.getMessageCountAndChanges(state.accountId).listen((countAndEvent) {
      final (newMessageCount, event) = countAndEvent;
      add(MessageCountChanged(newMessageCount, event?.change));
    });

    add(InitEvent());
  }

  @override
  Future<void> close() async {
    await _messageCountSubscription?.cancel();
    await _profileChangeSubscription?.cancel();
    return super.close();
  }
}

class MessageListUpdate {
  final MessageList allMessagesList;
  final MessageList onlyNewMessages;
  final bool jumpToLatestMessage;
  MessageListUpdate({
    required this.allMessagesList,
    required this.onlyNewMessages,
    required this.jumpToLatestMessage,
  });
}
