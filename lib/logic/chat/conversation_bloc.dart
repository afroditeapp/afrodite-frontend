import "dart:async";

import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:async/async.dart";
import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/chat/message_database_iterator.dart";
import "package:pihka_frontend/data/chat_repository.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
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

class ConversationBloc extends Bloc<ConversationEvent, ConversationData> with ActionRunner {
  final AccountRepository account = AccountRepository.getInstance();
  final ProfileRepository profile = ProfileRepository.getInstance();
  final MediaRepository media = MediaRepository.getInstance();
  final ChatRepository chat = ChatRepository.getInstance();

  StreamSubscription<(int, ConversationChanged?)>? _messageCountSubscription;
  StreamSubscription<ProfileChange>? _profileChangeSubscription;

  ConversationBloc(ProfileEntry entry) :
    super(ConversationData(accountId: entry.uuid)) {

    on<InitEvent>((data, emit) async {
      log.info("Set conversation bloc initial state");

      final isMatch = await chat.isInMatches(state.accountId);
      final isBlocked = await chat.isInSentBlocks(state.accountId) ||
        await chat.isInReceivedBlocks(state.accountId);

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
          final isMatch = await chat.isInMatches(state.accountId);
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
        if (await chat.sendBlockTo(state.accountId)) {
          emit(state.copyWith(
            isBlocked: true,
          ));
        }
      });
    });
    on<SendMessageTo>((data, emit) async {
      await runOnce(() async {
        await chat.sendMessageTo(data.accountId, data.message);
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
        final initialMessages = await chat.getAllMessages(state.accountId);
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
      final newMessages = await getNewMessages(state.accountId, lastMsg?.localId);
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

    _messageCountSubscription = chat.getMessageCountAndChanges(state.accountId).listen((countAndEvent) {
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
