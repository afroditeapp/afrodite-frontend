import "dart:async";
import "dart:io";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/chat_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/database/chat/message_database.dart";
import "package:pihka_frontend/utils.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'conversation_bloc.freezed.dart';

var log = Logger("ConversationBloc");

@freezed
class ConversationData with _$ConversationData {
  factory ConversationData({
    required AccountId accountId,
    required String profileName,
    required XFile primaryProfileImage,
    @Default(true) bool isMatch,
    @Default(false) bool isBlocked,
    /// Resets chat box to empty state
    @Default(false) bool isSendSuccessful,
    @Default(0) int messageCount,
    ConversationChangeType? messageCountChangeInfo,
    @Default(MessageList([])) MessageList initialMessages,
  }) = _ConversationData;
}

/// Wrapper for messages to prevent printing to console
class MessageList {
  final List<MessageEntry> messages;
  const MessageList(this.messages);
}

sealed class ConversationEvent {}
class SetConversationView extends ConversationEvent {
  final AccountId accountId;
  final String profileName;
  final XFile primaryProfileImage;
  SetConversationView(this.accountId, this.profileName, this.primaryProfileImage);
}
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

class ConversationBloc extends Bloc<ConversationEvent, ConversationData?> with ActionRunner {
  final AccountRepository account;
  final ProfileRepository profile;
  final MediaRepository media;
  final ChatRepository chat;

  StreamSubscription<(int, ConversationChanged?)>? _messageCountSubscription;
  StreamSubscription<ProfileChange>? _profileChangeSubscription;

  ConversationBloc(this.account, this.profile, this.media, this.chat) : super(null) {
    on<SetConversationView>((data, emit) async {
      log.info("Set conversation bloc initial state");
      emit(null);
      // For some reason this does not return.
      unawaited(_messageCountSubscription?.cancel());

      final newState = ConversationData(
        accountId: data.accountId,
        profileName: data.profileName,
        primaryProfileImage:
        data.primaryProfileImage,
        initialMessages: const MessageList([]),
      );

      final isMatch = await chat.isInMatches(newState.accountId);
      final isBlocked = await chat.isInSentBlocks(newState.accountId) ||
        await chat.isInReceivedBlocks(newState.accountId);
      final initialMessages = await chat.getAllMessages(newState.accountId);

      emit(newState.copyWith(
        isMatch: isMatch,
        isBlocked: isBlocked,
        initialMessages: MessageList(initialMessages),
        messageCount: initialMessages.length,
      ));

      _messageCountSubscription = chat.getMessageCountAndChanges(newState.accountId).listen((countAndEvent) {
        final (newMessageCount, event) = countAndEvent;
        log.info("Message count $newMessageCount received. Sending event about it.");
        add(MessageCountChanged(newMessageCount, event?.change));
      });
    });
    on<HandleProfileChange>((data, emit) async {
      final currentState = state;
      if (currentState == null) {
        return;
      }
      final change = data.change;
      switch (change) {
        case ProfileBlocked(): {
          if (change.profile == currentState.accountId) {
            emit(currentState.copyWith(isBlocked: true));
          }
        }
        case MatchesChanged(): {
          final isMatch = await chat.isInMatches(currentState.accountId);
          emit(currentState.copyWith(isMatch: isMatch));
        }
        case ProfileNowPrivate() ||
          ProfileUnblocked() ||
          LikesChanged() ||
          ConversationChanged() ||
          MatchesChanged() ||
          ProfileFavoriteStatusChange(): {}
      }
    });
    on<BlockProfile>((data, emit) async {
      await runOnce(() async {
        final currentState = state;
        if (currentState == null) {
          return;
        }
        if (await chat.sendBlockTo(currentState.accountId)) {
          emit(currentState.copyWith(
            isBlocked: true,
          ));
        }
      });
    });
    on<SendMessageTo>((data, emit) async {
      await runOnce(() async {
        final currentState = state;
        if (currentState == null) {
          return;
        }
        await chat.sendMessageTo(data.accountId, data.message);
      });
    });
    on<NotifyChatBoxCleared>((data, emit) async {
      final currentState = state;
      if (currentState == null) {
        return;
      }
      emit(currentState.copyWith(
        isSendSuccessful: false,
      ));
    });
    on<MessageCountChanged>((data, emit) async {
      final currentState = state;
      if (currentState == null) {
        return;
      }
      emit(currentState.copyWith(
        messageCount: data.newMessageCount,
        messageCountChangeInfo: data.changeInfo,
      ));
    });

    _profileChangeSubscription = ProfileRepository.getInstance()
      .profileChanges
      .listen((event) {
        add(HandleProfileChange(event));
      });
  }

  @override
  Future<void> close() async {
    await _messageCountSubscription?.cancel();
    await _profileChangeSubscription?.cancel();
    return super.close();
  }
}
