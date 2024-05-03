import "dart:async";

import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/chat_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/model/freezed/logic/chat/conversation_bloc.dart";
import "package:pihka_frontend/utils.dart";

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
      final initialMessages = await chat.getAllMessages(state.accountId);

      emit(state.copyWith(
        isMatch: isMatch,
        isBlocked: isBlocked,
        initialMessages: MessageList(initialMessages),
        messageCount: initialMessages.length,
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
      emit(state.copyWith(
        messageCount: data.newMessageCount,
        messageCountChangeInfo: data.changeInfo,
      ));
    });

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
