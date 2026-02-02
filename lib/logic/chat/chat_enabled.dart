import 'dart:async';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/model/freezed/logic/chat/chat_enabled.dart';
import 'package:app/utils/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

sealed class ChatEnabledEvent {}

class EnableChatWithNewKeypair extends ChatEnabledEvent {
  final bool ignorePendingMessages;
  EnableChatWithNewKeypair({this.ignorePendingMessages = false});
}

class ClearPendingMessagesWarning extends ChatEnabledEvent {}

class ChatEnabledBloc extends Bloc<ChatEnabledEvent, ChatEnabledData> {
  final ChatRepository chat;
  final ApiManager api;
  final AccountDatabaseManager db;
  final MessageKeyManager messageKeyManager;
  final AccountId currentUser;

  StreamSubscription<bool?>? _chatEnabledSubscription;

  ChatEnabledBloc(RepositoryInstances r)
    : chat = r.chat,
      api = r.api,
      db = r.accountDb,
      messageKeyManager = r.chat.messageKeyManager,
      currentUser = r.accountId,
      super(const ChatEnabledData()) {
    on<EnableChatWithNewKeypair>((event, emit) async {
      emit(state.copyWith(isEnabling: true));

      // Generate new keys (this will also upload and save to DB)
      final result = await messageKeyManager.generateNewKeypairAndUploadPublicKey(
        ignorePendingMessages: event.ignorePendingMessages,
      );

      switch (result) {
        case Ok():
          // The database will automatically update chatEnabled status
          // via the stream subscription
          emit(state.copyWith(isEnabling: false));
        case Err(:final e):
          switch (e) {
            case GenerateKeypairErrorPendingMessages():
              emit(state.copyWith(isEnabling: false, showPendingMessagesWarning: true));
            case GenerateKeypairErrorTooManyKeys():
              emit(
                state.copyWith(isEnabling: false, enableError: const ChatEnableErrorTooManyKeys()),
              );
            case GenerateKeypairErrorOther():
              emit(state.copyWith(isEnabling: false, enableError: const ChatEnableErrorOther()));
          }
      }
    });

    on<ClearPendingMessagesWarning>((event, emit) {
      emit(state.copyWith(showPendingMessagesWarning: false));
    });

    // Listen to database stream for chat enabled status
    _chatEnabledSubscription = db.accountStream((db) => db.key.watchChatEnabled()).listen((
      isEnabled,
    ) {
      add(_ChatEnabledChanged(isEnabled ?? false));
    });

    on<_ChatEnabledChanged>((event, emit) {
      emit(
        state.copyWith(
          chatEnabled: event.chatEnabled,
          enableError: null,
          showPendingMessagesWarning: false,
        ),
      );
    });
  }

  @override
  Future<void> close() async {
    await _chatEnabledSubscription?.cancel();
    return super.close();
  }
}

class _ChatEnabledChanged extends ChatEnabledEvent {
  final bool chatEnabled;
  _ChatEnabledChanged(this.chatEnabled);
}
